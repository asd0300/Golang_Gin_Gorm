package service

import (
	"GO_test/middle/jwt"
	"GO_test/pojo"
	"crypto/aes"
	"crypto/cipher"
	"crypto/sha1"
	"encoding/base64"
	"errors"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func PostRegisterUser(c *gin.Context) {
	user := pojo.User{}
	err := c.ShouldBindJSON(&user)
	if err != nil {
		return
	}
	pojo.CreateUser(user)
	c.JSON(http.StatusOK, "success")
}

// post login
func PostLoginUser(c *gin.Context) {
	user := pojo.User{}
	err := c.ShouldBindJSON(&user)
	if err != nil {
		return
	}
	result := pojo.FindByUserEmail(user)
	if result != nil {
		loginJWT, _ := jwt.GenerateJWT(strconv.Itoa(result.Id) + "," + result.Email)
		c.JSON(http.StatusOK, gin.H{"jwt": loginJWT})
		return
	}
	c.JSON(http.StatusNotFound, "Login failed")

}

// Encrypt
const EncryptCode = "it"

// sha
func sha1It(password string) string {
	h := sha1.New()
	h.Write([]byte(password))
	bs := h.Sum([]byte(EncryptCode))
	encryptCode := fmt.Sprintf("%x", bs)
	return encryptCode
}

func decrypt(encryptedData, keyString, ivString string) (string, error) {
	key := []byte(keyString)
	iv := []byte(ivString)

	// 解码加密数据（假设是 base64 编码的）
	ciphertext, err := base64.StdEncoding.DecodeString(encryptedData)
	if err != nil {
		return "", err
	}

	// 创建 AES 块
	block, err := aes.NewCipher(key)
	if err != nil {
		return "", err
	}

	// 创建 CBC 模式的解密器
	if len(ciphertext) < aes.BlockSize {
		return "", errors.New("ciphertext too short")
	}
	if len(ciphertext)%aes.BlockSize != 0 {
		return "", errors.New("ciphertext is not a multiple of the block size")
	}
	mode := cipher.NewCBCDecrypter(block, iv)

	// 解密
	mode.CryptBlocks(ciphertext, ciphertext)

	// 移除 PKCS#7 填充
	return unpadPKCS7(ciphertext), nil
}

// unpadPKCS7 移除 PKCS#7 填充
func unpadPKCS7(data []byte) string {
	length := len(data)
	unpadding := int(data[length-1])

	return string(data[:(length - unpadding)])
}
