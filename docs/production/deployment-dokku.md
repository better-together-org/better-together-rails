
# Dokku Deployment

Create application:

```bash
dokku apps:create community-engine
```

Create PostgreSQL service

```bash
dokku postgres:create community-engine
```

Link the PostgreSQL service to the app.

```bash
dokku postgres:link community-engine community-engine
```

Create Redis service

```bash
dokku redis:create community-engine
```

Link the Redis service to the app.

```bash
dokku redis:link community-engine community-engine
```

## Set build variables

``` bash
dokku docker-options:add communityengine.app build '--build-arg AWS_ACCESS_KEY_ID'
dokku docker-options:add communityengine.app build '--build-arg AWS_SECRET_ACCESS_KEY'
dokku docker-options:add communityengine.app build '--build-arg FOG_DIRECTORY'
dokku docker-options:add communityengine.app build '--build-arg FOG_HOST'
dokku docker-options:add communityengine.app build '--build-arg FOG_REGION'
dokku docker-options:add communityengine.app build '--build-arg ASSET_HOST'
dokku docker-options:add communityengine.app build '--build-arg CDN_DISTRIBUTION_ID'
```

If you have any questions or suggestions for ways to improve this or any other documentation, please create an issue or a pull request to let us know.