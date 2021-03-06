FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS publish
ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
WORKDIR /app
COPY . .
RUN dotnet publish Dummy \
    --configuration Release \
    --output /app/publish \
    --runtime alpine-x64 \
    --self-contained true

FROM mcr.microsoft.com/dotnet/runtime-deps:6.0-alpine AS final
WORKDIR /app
RUN adduser --disabled-password --home /app --gecos '' dotnetuser \
    && chown -R dotnetuser /app
USER dotnetuser
EXPOSE 5000
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS=http://+:5000
ENTRYPOINT ["./Dummy"]
