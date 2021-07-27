FROM mcr.microsoft.com/dotnet/sdk:5.0
WORKDIR /app
RUN apt-get update \ 
  && apt-get install -y curl \
  && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
COPY . /app
RUN dotnet build
WORKDIR DotnetTemplate.Web
RUN npm install
RUN npm run build
ENTRYPOINT dotnet run
