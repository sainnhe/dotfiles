#!/usr/bin/env python

# Colored Logger from https://stackoverflow.com/questions/384076/how-can-i-color-python-logging-output

import os
import logging
import time
import random

BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(8)

# The background is set with 40 plus the number of the color, and the
# foreground with 30

# These are the sequences need to get colored ouput
RESET_SEQ = "\033[0m"
COLOR_SEQ = "\033[1;%dm"
BOLD_SEQ = "\033[1m"


def formatter_message(message, use_color=True):
    if use_color:
        message = message.replace(
            "$RESET", RESET_SEQ).replace("$BOLD", BOLD_SEQ)
    else:
        message = message.replace("$RESET", "").replace("$BOLD", "")
    return message

COLORS = {
    'WARNING': CYAN,
    'INFO': MAGENTA,
    'DEBUG': BLUE,
    'CRITICAL': YELLOW,
    'ERROR': RED
}


class ColoredFormatter(logging.Formatter):

    def __init__(self, msg, use_color=True):
        logging.Formatter.__init__(self, msg)
        self.use_color = use_color

    def format(self, record):
        levelname = record.levelname
        if self.use_color and levelname in COLORS:
            levelname_color = COLOR_SEQ % (
                30 + COLORS[levelname]) + levelname + RESET_SEQ
            record.levelname = levelname_color
        return logging.Formatter.format(self, record)


# Custom logger class with multiple destinations
class ColoredLogger(logging.Logger):
    FORMAT = "[%(asctime)s] [%(levelname)s] %(message)s"
    COLOR_FORMAT = formatter_message(FORMAT, True)

    def __init__(self, name):
        logging.Logger.__init__(self, name, logging.DEBUG)

        color_formatter = ColoredFormatter(self.COLOR_FORMAT)

        console = logging.StreamHandler()
        console.setFormatter(color_formatter)

        self.addHandler(console)
        return

logging.setLoggerClass(ColoredLogger)
logger = logging.getLogger(__name__)
# logging.basicConfig(format='[%(asctime)s] %(filename)s:%(lineno)d %(levelname)s %(message)s',
#                    level=logging.DEBUG)



def get_random_system_info():
    path = os.environ['PATH']
    pwd = os.environ['PWD']
    tmpdir = os.environ.get('TMPDIR', '/tmp/')
    home = os.environ['HOME']

    return random.choice([path, pwd, tmpdir, home])

def get_random_nodejs_package():
    modules = [
        "underscore", "async", "request", "lodash", "commander", "express", "optimist", "colors", "coffee-script",
        "mkdirp", "debug", "q", "chalk", "yeoman-generator", "moment", "glob", "through2", "jade", "uglify-js",
        "socket.io", "gulp-util", "redis", "cheerio", "through", "node-uuid", "connect", "winston", "mime",
        "minimist", "bluebird", "grunt", "handlebars", "mongodb", "rimraf", "semver", "ejs", "mongoose", "marked",
        "xml2js", "underscore.string", "fs-extra", "mocha", "js-yaml", "superagent", "less", "extend", "esprima",
        "jquery", "stylus", "body-parser", "xtend", "jsdom", "event-stream", "shelljs", "minimatch", "prompt",
        "browserify", "wrench", "ws", "mysql", "readable-stream", "yosay", "inherits", "when", "pkginfo",
        "backbone", "nopt", "cli-color", "concat-stream", "passport", "nodemailer", "gulp", "chai", "inquirer",
        "nconf", "validator", "yargs", "mustache", "qs", "clean-css", "npm", "ncp", "should", "open", "aws-sdk",
        "graceful-fs", "temp", "http-proxy", "iconv-lite", "requirejs", "socket.io-client", "hiredis", "uuid",
        "promise", "escodegen", "bower", "oauth", "log4js", "cli-table"
    ]

    return random.choice(modules)


def get_random_status():
    all_status = [
        "100 Continue", "101 Switching Protocols", "102 Processing", "200 OK", "201 Created", "202 Accepted",
        "203 Non-Authoritative Information", "204 No Content", "205 Reset Content", "206 Partial Content",
        "207 Multi-Status", "208 Already Reported", "226 IM Used (RFC 3229)", "300 Multiple Choices",
        "301 Moved Permanently", "302 Found", "303 See Other", "304 Not Modified", "305 Use Proxy",
        "306 Switch Proxy", "307 Temporary Redirect", "308 Permanent Redirect", "prepublish", "postinstall",
        "install", "rebuildBundles", "linkMans", "linkBins", "linkStuff", "install", "about to build", "addNamed",
        "lock", "etag", "parsed url", "search", "query", "host", "auth", "slashes", "cache add", "GET", "POST",
        "trying", "installOne", "tar unpack"
    ]
    return random.choice(all_status)

def get_random_version():
    major_ver = random.randint(1, 9)
    minor_ver = random.randint(1, 9)
    dev_ver = random.randint(1, 9)

    return "v" + str(major_ver) + "." + str(minor_ver) + "." + str(dev_ver)

def get_random_message():
    sentences = [
        "it worked if it ends with ok",
        "cli [ 'node', '" + get_random_system_info() + "','install','--verbose' ]",
        "using npm@1.4.28 " + get_random_system_info(),
        "using node@v0.10.32",
        "readDependencies using package.json deps",
        "install where, deps " + get_random_system_info() + ", [ '" + get_random_nodejs_package() + "' ] ]",
        "readDependencies using package.json deps",
        "already installed skipping " + get_random_nodejs_package() + "@" + get_random_version(),
        "already installed skipping boganipsum@0.1.0 " + get_random_system_info(),
        "build /Users/samuel/Documents/bebusy",
        "linkStuff [false, false, false, '/Users/samuel/Documents']",
        "rebuildBundles " + get_random_nodejs_package() + "@" + get_random_version(),
        "rebuildBundles ['.bin', 'boganipsum', 'colors']",
        "install " + get_random_nodejs_package() + "@" + get_random_version(),
        "postinstall " + get_random_nodejs_package() + "@" + get_random_version(),
        "prepublish " + get_random_nodejs_package() + "@" + get_random_version(),
        "preinstall " + get_random_nodejs_package() + "@" + get_random_version(),
        "linkStuff " + get_random_nodejs_package() + "@" + get_random_version(),
        "linkBins " + get_random_nodejs_package() + "@" + get_random_version(),
        "linkMans " + get_random_nodejs_package() + "@" + get_random_version(),
        "exit [0, true]",
        "ok"
    ]
    return random.choice(sentences)

if __name__ == "__main__":
    func_list = [logger.info, logger.debug, logger.warn, logger.error, logger.critical]
    while True:
        f = random.choice(func_list)
        f(get_random_message())
        time.sleep(random.random() / 5)
