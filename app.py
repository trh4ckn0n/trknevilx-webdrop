from flask import Flask, render_template, redirect, url_for
import subprocess

app = Flask(__name__)
SERVICE_NAME = "gpt4_calc.service"

def run(cmd):
    return subprocess.getoutput(cmd)

@app.route('/')
def index():
    status = run(f"systemctl is-active {SERVICE_NAME}")
    return render_template("index.html", status=status)

@app.route('/start')
def start():
    run(f"systemctl start {SERVICE_NAME}")
    return redirect(url_for('index'))

@app.route('/stop')
def stop():
    run(f"systemctl stop {SERVICE_NAME}")
    return redirect(url_for('index'))

@app.route('/logs')
def logs():
    output = run(f"journalctl -u {SERVICE_NAME} --no-pager | tail -n 30")
    return f"<pre>{output}</pre>"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
