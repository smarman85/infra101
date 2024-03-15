package main

import (
	"fmt"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	listenOn := os.Getenv("PORT")
	router := gin.Default()
	router.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
			"port":    listenOn,
		})
	})
	router.Run(fmt.Sprintf(":%s", listenOn))
}
