package jwt

import (
	"net/http"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
)

type Userjwt struct {
	Username             string `json:"username"`
	jwt.RegisteredClaims        // v5版本新加的方法
}

var secretKey string = "benfan"

// 生成 jwt
func GenerateJWT(username string) (string, error) {

	claims := Userjwt{
		username,
		jwt.RegisteredClaims{
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(24 * time.Hour)),
			IssuedAt:  jwt.NewNumericDate(time.Now()),
			NotBefore: jwt.NewNumericDate(time.Now()),
		},
	}
	// 使用HS256
	t := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	s, err := t.SignedString([]byte(secretKey))

	return s, err
}

// 解析 jwt
func ParseJwt(tokenstring string) (*Userjwt, error) {
	t, err := jwt.ParseWithClaims(tokenstring, &Userjwt{}, func(token *jwt.Token) (interface{}, error) {
		return []byte(secretKey), nil
	})

	if claims, ok := t.Claims.(*Userjwt); ok && t.Valid {
		return claims, nil
	} else {
		return nil, err
	}
}

func JWTAuthMiddleware() func(c *gin.Context) {
	return func(c *gin.Context) {
		//Get token
		authHeader := c.Request.Header.Get("userToken")
		if authHeader == "" {
			c.JSON(http.StatusUnauthorized, gin.H{
				"code": -1,
				"msg":  "Authorization is null",
			})
			c.Abort()
			return
		}
		parts := strings.SplitN(authHeader, " ", 2)
		// if !(len(parts) == 2 && parts[0] == "Bearer") {
		// 	c.JSON(http.StatusUnauthorized, gin.H{
		// 		"code": -1,
		// 		"msg":  "Format of authroization wrong",
		// 	})
		// 	c.Abort()
		// 	return
		// }
		mc, err := ParseJwt(parts[0])
		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{
				"code": -1,
				"msg":  "Invalid Token.",
			})
			c.Abort()
			return
		}
		c.Set("Username", mc.Username)
		// After that, we can get Account info from c.Get("account")
		c.Next()
	}
}
