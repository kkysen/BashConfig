# w/o this, strftime() stat()s /etc/localtime many times, slowing things down a lot
export TZ=":/etc/localtime"
