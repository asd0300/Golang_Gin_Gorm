package main

import (
	"container/heap"
	"fmt"
	"time"
)

// import "fmt"

func main() {
	// lengthOfLongestSubstring("abcabcbb")
	// test := [][]int{{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10, 11, 12}}
	// spiralOrder(test)
	// haystack := "hello"
	// needle := "ll"
	// strStr(haystack, needle)
	// TestIota()
	test()
}

// func searchData(s string, searchers []func(string) []string) []string {
// 	done := make(chan struct{})
// 	result := make(chan []string)
// 	for _, searcher := range searchers {
// 		go func(searcher func(string) []string) {
// 			select {
// 			case result <- searcher(s):
// 			case <-done:
// 			}
// 		}(searcher)
// 	}
// 	r := <-result
// 	close(done)
// 	return r
// }

// 關閉 select case
// func closeSelectCase() {
// 	for {
// 		select {
// 		case v, ok := <-in:
// 			if !ok {
// 				in = nil // 這個case絕對不會再次成功
// 				continue
// 			}
// 		case v, ok := <-i2n:
// 			if !ok {
// 				in2 = nil // 這個case絕對不會再次成功
// 				continue
// 			}
// 		case <-done:
// 			return
// 		}
// 	}
// }

func goroutineVarialble() {
	a := []int{2, 4, 6, 8, 10}
	ch := make(chan int, len(a))
	for _, v := range a {
		v := v
		go func() {
			ch <- v * 2
		}()
	}
}

func test() {
	// 创建一个容量为2的有缓冲channel
	ch := make(chan int, 2)

	// 启动一个goroutine来接收数据
	go func() {
		for i := 0; i < 3; i++ {
			num := <-ch
			fmt.Println("接收到数据:", num)
		}
	}()

	// 向channel发送数据
	ch <- 1
	fmt.Println("发送数据: 1")
	ch <- 2
	fmt.Println("发送数据: 2")

	// 因为缓冲区大小为2，所以第三次发送会被阻塞，直到有接收者接收数据
	ch <- 3
	fmt.Println("发送数据: 3")

	// 等待一段时间以确保所有输出都被打印
	time.Sleep(1 * time.Second)
}

const (
	ta1 = 1 << iota
	ta2
	ta3
)

func TestIota() {
	fmt.Printf("%d\n", ta1)
	fmt.Printf("%d\n", ta2)
	fmt.Printf("%d\n", ta3)
}

type Student struct {
	Name string
	Age  int
	Addr string
}

func PrintpresentV() {
	test := &Student{Name: "Ben", Age: 35, Addr: "Hsinchu"}
	fmt.Printf("%v\n", test)
	fmt.Printf("%+v\n", test)
	fmt.Printf("%#v\n", test)
}

// func L67(a string, b string) string {
// 	i, j = len(a)-1, len(b)-1
// 	carry :=0
// 	result :=""

// 	for i>=0
// }

type IntHeap []int

func (h IntHeap) Len() int {
	return len(h)
}
func (h IntHeap) Less(i, j int) bool {
	return h[i] < h[j]
}
func (h IntHeap) Swap(i, j int) {
	h[i], h[j] = h[j], h[i]
}
func (h *IntHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *IntHeap) Pop() interface{} {
	old := *h
	n := len(*h)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func L215(nums []int, target int) int {
	h := &IntHeap{}
	heap.Init(h)
	for _, num := range nums {
		heap.Push(h, num)
		if h.Len() > target {
			heap.Pop(h)
		}
	}
	return (*h)[0]

}

func L200numIslands(grid [][]byte) int {

	//check row
	m := len(grid)
	if m == 0 {
		return 0
	}
	n := len(grid[0])
	//製作visit map
	res, visited := 0, make([][]bool, m)
	for i := 0; i < m; i++ {
		visited[i] = make([]bool, n)
	}
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == '1' && !visited[i][j] {
				SearchIsland(grid, &visited, i, j)
				res++
			}
		}
	}
	return res
}

func SearchIsland(grid [][]byte, visited *[][]bool, i, j int) {
	dir := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
	(*visited)[i][j] = true
	for k := 0; k < 4; k++ {
		nx := i + dir[k][0]
		ny := j + dir[k][1]
		if isInBoard(grid, nx, ny) && !(*visited)[nx][ny] && grid[nx][ny] == '1' {
			SearchIsland(grid, visited, nx, ny)
		}
	}
}

func isInBoard(grid [][]byte, x, y int) bool {
	m := len(grid)
	if m == 0 {
		return false
	}
	n := len(grid[0])
	return x >= 0 && x < m && y >= 0 && y < n
}

//	var dict = map[string][]string{
//		"2": []string{"a", "b", "c"},
//		"3": []string{"d", "e", "f"},
//		"4": []string{"g", "h", "i"},
//		"5": []string{"j", "k", "l"},
//		"6": []string{"m", "n", "o"},
//		"7": []string{"p", "q", "r", "s"},
//		"8": []string{"t", "u", "v"},
//		"9": []string{"w", "x", "y", "z"},
//	}
var result = []string{}

// func L17(digit string) []string {
// 	if digit == "" {
// 		return []string{""}
// 	}
// 	letterfunc("", digit)
// 	return result
// }

// func letterfunc(res string, digit string) {
// 	if digit == "" {
// 		result = append(result, res)
// 		return
// 	}
// 	k := digit[0:1]
// 	digit = digit[1:]
// 	for i := 0; i < len(dict[k]); i++ {
// 		res += dict[k][i]
// 		letterfunc(res, digit)
// 		res = res[0 : len(res)-1]
// 	}
// }

func strStr(haystack string, needle string) int {
	for i := 0; ; i++ {
		for j := 0; ; j++ {
			if j == len(needle) {
				return i
			}
			if i+j == len(haystack) {
				return -1
			}
			if needle[j] != haystack[i+j] {
				break
			}
		}
	}
}

func lengthOfLongestSubstring(s string) int {
	var checkac2 [127]int
	if len(s) == 0 {
		return 0
	}
	result, left, right := 0, 0, -1
	for left < len(s) {
		if (right+1) < len(s) && checkac2[s[right+1]] == 0 {
			checkac2[s[right+1]]++
			right++
		} else {
			checkac2[s[left]]--
			left++
		}
		result = max(result, right-left+1)

	}
	return result
}

func spiralOrder(matrix [][]int) []int {
	top := 0
	bottom := len(matrix) - 1
	left := 0
	right := len(matrix[0]) - 1
	result := []int{}
	cnt := 1
	for top <= bottom && left <= right {
		//top
		if cnt == 1 {
			for i := left; i <= right; i++ {
				result = append(result, matrix[top][i])
			}
			cnt = 2
			top++
		} else if cnt == 2 {
			//rigth part
			for i := top; i <= bottom; i++ {
				result = append(result, matrix[i][right])
			}
			cnt = 3
			right--
		} else if cnt == 3 {
			//bottom part
			for i := right; left <= i; i-- {
				result = append(result, matrix[bottom][i])
			}
			cnt = 4
			bottom--
		} else if cnt == 4 {
			//left part
			for i := bottom; top <= i; i-- {
				result = append(result, matrix[i][left])
			}
			cnt = 1
			left++
		}
	}
	return result
}
