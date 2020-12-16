FROM alpine:3

RUN apk --no-cache add git python3 nodejs npm fzf ripgrep alpine-sdk ncurses-dev curl && \ 
npm install --global yarn && \ 
mkdir /build && \
cd /build && \
git clone --branch v8.2.1916 --depth 1 https://github.com/vim/vim.git  && \
cd vim && \
make && \
make install && \
cd / && \
rm -rf /build && \ 
apk del alpine-sdk ncurses-dev 

COPY .vimrc /root/.vimrc

ENV TERM=screen-256color

ENTRYPOINT ["sh"]
