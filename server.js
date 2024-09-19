const http = require('http');
const fs = require('fs');
const path = require('path');

const port = 8080;
const directory = __dirname; // Serve files from the current directory

const server = http.createServer((req, res) => {
    // Construct the file path
    let filePath = path.join(directory, req.url === '/' ? 'index.html' : req.url);

    // Check if the file exists
    fs.stat(filePath, (err, stats) => {
        if (err || !stats.isFile()) {
            // File not found
            res.writeHead(404, { 'Content-Type': 'text/html' });
            res.end('<html><body><h1 style="color:red;">The page you requested is not available</h1></body></html>');
        } else {
            // Serve the file
            fs.readFile(filePath, (err, data) => {
                if (err) {
                    res.writeHead(500, { 'Content-Type': 'text/html' });
                    res.end('<html><body><h1 style="color:red;">Internal Server Error</h1></body></html>');
                } else {
                    res.writeHead(200, { 'Content-Type': 'text/html' });
                    res.end(data);
                }
            });
        }
    });
});

server.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});
