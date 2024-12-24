package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/SakamotoHiroya/ai-todo-app/internal/middleware"
	api "github.com/SakamotoHiroya/ai-todo-app/internal/ogen"
	"github.com/SakamotoHiroya/ai-todo-app/internal/ogen/handler"
	"github.com/SakamotoHiroya/ai-todo-app/internal/service"
)

func main() {
	// Initialize services
	svc := service.New()

	// Initialize handler
	h := handler.New(svc)
	s := handler.NewSecurityHandler()

	// Initialize server
	srv, err := api.NewServer(h, s, api.WithMiddleware(middleware.Logging()))
	if err != nil {
		log.Fatalf("Failed to create server: %v", err)
	}

	// Start server
	server := &http.Server{
		Addr:    ":8080",
		Handler: srv,
	}

	// Run server in a goroutine
	go func() {
		log.Printf("Starting server on :8080")
		if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("Server error: %v", err)
		}
	}()

	// Graceful shutdown
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit

	log.Println("Shutting down server...")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := server.Shutdown(ctx); err != nil {
		log.Fatalf("Server forced to shutdown: %v", err)
	}

	log.Println("Server exited properly")
}
