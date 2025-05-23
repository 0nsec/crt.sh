# crt.sh

 powerful and versatile domain search tool that fetches subdomains and related domains from SSL certificates using the [crt.sh](https://crt.sh/) database. Perfect for bug bounty hunters, penetration testers, and security researchers!


## Features

- **Subdomain Enumeration**: Discover subdomains and related domains for any given domain.
- **Multiple Domain Support**: Process multiple domains in a single run.
- **Output Formats**: Save results in **text** or **JSON** format.
- **Verbose Mode**: Enable detailed logging for debugging and progress tracking.
- **Rate Limiting**: Add delays between requests to avoid overloading the server.
- **Error Logging**: Automatically logs errors to `error.log` for easy debugging.
- **User-Friendly**: Color-coded output and clear progress indicators.


---

## Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/0nsec/crt.sh.git
   ```
   ```
   cd domain-search-engine
   ```
### Install Dependencies:
```
sudo apt update && sudo apt install curl jq
```

## **Usage**:

Basic Usage:
```bash


./crt.sh example.com
```
Multiple Domains:
```bash

./crt.sh example.com example.org
```
Verbose Mode:
```bash
./crt.sh -v example.com
```
JSON Output:
```bash
./crt.sh -o json example.com
```
Custom Delay:
```bash
./crt.sh -d 2 example.com
```
Combined Options:
```bash
./crt.sh -v -o json -d 2 example.com example.org
```
---
Credits

  * Author: Notyoursxx0

 * GitHub: Github.com/0nsec

 * Inspiration: crt.sh

---

```sh
██████╗ ███╗   ██╗███████╗███████╗ ██████╗
██╔═████╗████╗  ██║██╔════╝██╔════╝██╔════╝
██║██╔██║██╔██╗ ██║███████╗█████╗  ██║     
████╔╝██║██║╚██╗██║╚════██║██╔══╝  ██║     
╚██████╔╝██║ ╚████║███████║███████╗╚██████╗
 ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝ ╚═════╝
```

