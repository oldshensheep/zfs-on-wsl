import configparser
import sys

def f(p, kernel):
    cfg = configparser.ConfigParser()
    cfg.read(p)
    cfg['wsl2']['kernel'] = kernel
    with open(p, "w") as f:
        cfg.write(f)

if __name__ == "__main__":
    arg_from_shell = sys.argv[1]
    kernel = sys.argv[2] 
    f(arg_from_shell, kernel)  
