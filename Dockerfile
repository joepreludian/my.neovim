FROM docker.io/python:3.8-alpine

WORKDIR /app

COPY local.pth /usr/local/lib/python.3.8/site-packages/

RUN apk add --virtual .build-deps \
        gcc python-dev musl-dev libffi-dev

RUN apk add neovim git wget curl
RUN pip install neovim && apk del .build-deps

ADD https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim /root/.local/share/nvim/site/autoload/plug.vim
ADD https://raw.githubusercontent.com/joepreludian/my.vim/master/init.vim /root/.config/nvim/

RUN nvim +'PlugInstall --sync' +qa

CMD tail -f /dev/null
