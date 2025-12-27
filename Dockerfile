# # Build stage (use alpine-based gcc for better compatibility)
# # FROM gcc:14.2.0 AS builder # Or try alpine-gcc images if you want even smaller build stage

# # Or try alpine-gcc images if you want even smaller build stage
# # FROM gcc:15.2.0-trixie AS builder

# # light but have no other tag
# FROM frolvlad/alpine-gcc:latest AS builder
# # https://hub.docker.com/r/frolvlad/alpine-gcc

# Builder stage: Use lightweight Alpine-based GCC
FROM frolvlad/alpine-gcc:latest AS builder

WORKDIR /app

# Copy source
COPY main.c .

# Compile fully static binary
# Optional: Strip for smaller size

RUN gcc -static -o myapplication main.c && strip myapplication


# Runtime stage: Truly minimal (no OS, just the binary)
FROM scratch

# Copy the static binary
COPY --from=builder /app/myapplication /myapplication

# Run it
CMD ["/myapplication"]