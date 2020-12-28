import subprocess
import sys

def getpywin():
    try:
        import win32con
    except ImportError:
        subprocess.check_call([sys.executable, "-m", "pip", "-q", "--no-warn-script-location", "install", "--upgrade", "pip"])
        subprocess.check_call([sys.executable, "-m", "pip", "-q", "install", "pywin32"])

if __name__ == '__main__':
    getpywin()