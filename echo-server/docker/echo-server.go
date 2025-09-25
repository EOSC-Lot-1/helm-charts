package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {
	// Dump headers to JSON for response
	headers := map[string][]string(r.Header)
	response := map[string]interface{}{
		"method":  r.Method,
		"url":     r.URL.String(),
		"headers": headers,
		"remote":  r.RemoteAddr,
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)

    // Print access log
	fmt.Printf("[%s] %s -- %s %s\n", time.Now().Format(time.RFC3339), r.RemoteAddr, r.Method, r.URL.Path)
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Starting echo server on :8080")
	http.ListenAndServe(":8080", nil)
}
