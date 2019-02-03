#Build Stage
FROM microsoft/dotnet:2.2-sdk as build-env
WORKDIR /is4aspid
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -o /publish 

# Runtime Image
# FROM microsoft/dotnet:2.2-aspnetcore-runtime AS runtime
FROM build-env AS runtime
WORKDIR /publish
COPY --from=build-env /publish .
ENTRYPOINT [ "dotnet", "is4aspid.dll", "--environment=Development" ]