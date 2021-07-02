package utils

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

const alphaber = "abcdefghijklmnopqrstuvwxyz"

func init() {
	rand.Seed(time.Now().UnixNano())
}

// RandomInt mengenareate random integer minimunm dan maximum
func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)

}

// RandomString menegenare sebuah random string dari length of n
func RandomString(n int) string {
	var sb strings.Builder
	k := len(alphaber)

	for i := 0; i < n; i++ {
		c := alphaber[rand.Intn(k)]
		sb.WriteByte(c)
	}
	return sb.String()
}

// RandomEmail generates a random email
func RandomEmail() string {
	return fmt.Sprintf("%s@gmail.com", RandomString(6))
}
