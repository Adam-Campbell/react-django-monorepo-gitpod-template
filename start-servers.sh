#!/bin/bash

# Function to stop both servers with single command
cleanup() {
    echo "Stopping Servers..."
    kill $BACKEND_PID $FRONTEND_PID
    exit 0
}


# Call cleanup function when interrupt signal is detected
trap cleanup SIGINT


# Start backend server
cd backend
python manage.py runserver 0.0.0.0:8000 &
BACKEND_PID=$!

# Start frontend server
cd ../frontend
npm run dev &
FRONTEND_PID=$!

# Wait for both processes
wait $BACKEND_PID $FRONTEND_PID


