# Makefile for docker-hello-world-c

IMAGE_NAME = docker-hello-world-c
TAG = latest

# Binary produced in container
BINARY_NAME = myapplication

# Name on host after extraction
HOST_BINARY = myapplication

.PHONY: all build run size extract clean

all: extract

build:
	docker build -t $(IMAGE_NAME):$(TAG) .

run: build
	docker run --rm $(IMAGE_NAME):$(TAG)

size: build
	docker image ls $(IMAGE_NAME):$(TAG)

# === EXTRACT STATIC BINARY TO HOST ===
extract:
	@echo "Building static binary and extracting to host as $(HOST_BINARY)..."
	
	# Step 1: Build only the builder stage and tag it temporarily
	docker build --target builder -t temp-builder .
	# Step 2: Create a temporary container from builder (but don't run it)
	docker create --name temp-container temp-builder	
	# Step 3: Copy the binary from container to host
	docker cp temp-container:/app/$(BINARY_NAME) ./$(HOST_BINARY)	
	# Step 4: Clean up temp container and image
	docker rm temp-container
	docker rmi temp-builder
	
	@echo "Extracted static binary: ./$(HOST_BINARY)"
	@echo "You can now run it directly: ./$(HOST_BINARY)"
	@chmod +x ./$(HOST_BINARY)  # Make it executable

clean:
	docker rmi $(IMAGE_NAME):$(TAG) 2>/dev/null || true
	docker rmi $(IMAGE_NAME)-temp 2>/dev/null || true
	docker image prune -f
	rm -f $(BINARY_NAME) $(HOST_BINARY)

