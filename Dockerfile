FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source
RUN apt-get update \ 
  && apt-get install -y curl \
  && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# copy csproj and restore as distinct layers
COPY *.sln .
COPY DotnetTemplate.Web/*.csproj ./DotnetTemplate.Web/
COPY DotnetTemplate.Web.Tests/*.csproj ./DotnetTemplate.Web.Tests/
RUN dotnet restore

# copy everything else and build app
COPY DotnetTemplate.Web/. ./DotnetTemplate.Web/
WORKDIR /source/DotnetTemplate.Web
RUN dotnet publish -c release -o /app 

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app 
COPY --from=build ./app ./
ENTRYPOINT ["dotnet", "DotnetTemplate.Web.dll"]
