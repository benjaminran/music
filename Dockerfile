FROM linuxbrew/linuxbrew

# dependencies
RUN brew update 
RUN brew install gcc python libxml2
RUN sudo apt-get update && sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev libxslt1-dev libxml2-dev python-pip
RUN sudo pip install backports.ssl_match_hostname
RUN brew install python3
RUN pip3 install --upgrade pip setuptools wheel
RUN install docker
RUN brew install --HEAD https://raw.githubusercontent.com/jeffkowalski/geeknote/master/geeknote.rb

#ruby imagemagick tesseract-ocr
#RUN git clone https://github.com/sstephenson/bats.git /usr/local/lib/bats \
# && /usr/local/lib/bats/install.sh /usr/local

# app
ADD bin /app/bin
ADD lib /app/lib
ADD conf /app/conf
ADD test /app/test

ENV PATH "${PATH}:/app/bin"
