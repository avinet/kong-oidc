local typedefs = require "kong.db.schema.typedefs"

local shared = ngx.shared
local store = shared['sessions']

return {
  ["/oidc/refresh_user"] = {
    GET = function(self)
      return kong.response.exit(200, { timestamp = store["renewal_" .. self.params.user] })
    end,

    POST = function(self)
      store["renewal_" .. self.params.user] = self.params.timestamp
      return kong.response.exit(201, { success = true })
    end,
  },
}