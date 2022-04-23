# Use thttpd
# https://lipanski.com/posts/smallest-docker-image-static-website

FROM alpine:3.15

RUN apk add --no-cache thttpd

# Create a non-root user to own the files and run our server
RUN adduser -D static
USER static
WORKDIR /home/static

# Copy with correct permission, see https://linux.die.net/man/8/thttpd
# In summary, data files should be mode 644 (rw-r--r--), directories should be 755 (rwxr-xr-x)
# https://stackoverflow.com/questions/3740152/how-to-change-permissions-for-a-folder-and-its-subfolders-files-in-one-step
# For all files
COPY --chown=static --chmod=644 src/ .
# Restore +x on folders only
RUN find . -type d -exec chmod 755 {} \;

# Run thttpd
CMD ["thttpd", "-D", "-h", "0.0.0.0", "-p", "3000", "-d", "/home/static", "-u", "static", "-l", "-", "-M", "60"]
