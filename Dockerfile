FROM alpine:3

RUN apk add bash git python3 nodejs npm curl alpine-sdk build-base clang ncurses-dev fzf ripgrep tmux

RUN npm install --global yarn &&\ 
mkdir /build &&\
cd /build &&\
git clone --branch v8.2.1916 --depth 1 https://github.com/vim/vim.git  &&\
cd vim &&\
make &&\
make install  &&\
cd /build &&\
rm -rf /build/vim

COPY .vimrc /root/.vimrc
COPY .tmux.conf /root/.tmux.conf

ENV TERM=screen-256color

ENTRYPOINT ["bash"]
