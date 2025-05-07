

https://github.com/ekkinox/yai



import argparse
import time
import requests

def analyze_log_content(log_content, custom_message=None):
    prompt = custom_message or "Please analyze the following log content for errors and provide suggestions:"
    payload = {
        "model": "mistral",
        "prompt": f"{log_content}\n\n{prompt}"
    }
    response = requests.post("http://127.0.0.1:11434/api/generate", json=payload)
    if response.ok:
        print("Analysis result:\n", response.json().get("completion", "No output"))
    else:
        print("Error communicating with Ollama API:", response.text)

def tail_and_analyze(file_path, interval=5):
    with open(file_path, "r") as f:
        # Move to the end of the file
        f.seek(0, 2)
        while True:
            line = f.readline()
            if not line:
                time.sleep(interval)
                continue
            # For simplicity, analyze each new line or batch lines as needed
            analyze_log_content(line.strip())

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Continuously analyze a log file with Ollama Mistral.")
    parser.add_argument("logfile", help="Path to the log file to monitor")
    parser.add_argument("--interval", type=int, default=5, help="Polling interval in seconds")
    args = parser.parse_args()

    tail_and_analyze(args.logfile, args.interval)



#########################################  2222222222222222222



import time
import requests

def tail_log_and_analyze(file_path, interval=5):
    with open(file_path, 'r') as f:
        f.seek(0, 2)  # Move to end of file
        while True:
            line = f.readline()
            if not line:
                time.sleep(interval)
                continue
            analyze_with_ollama(line.strip())

def analyze_with_ollama(text):
    prompt = f"Analyze the following log line and identify any errors or issues:\n{text}"
    payload = {
        "model": "mistral",
        "prompt": prompt
    }
    response = requests.post("http://localhost:11434/api/generate", json=payload)
    if response.ok:
        result = response.json().get("completion", "")
        print("Analysis:", result)
    else:
        print("Error:", response.text)

if __name__ == "__main__":
    log_file_path = "/path/to/your/logfile.log"
    tail_log_and_analyze(log_file_path)


