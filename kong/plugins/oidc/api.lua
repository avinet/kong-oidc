local typedefs = require "kong.db.schema.typedefs"

local schema = {
  name         = "user_refreshed",
  workspaceable = true,

  fields = {
    { timestamp     = typedefs.auto_timestamp_s },
  },
}

local shared = ngx.shared
local store = shared['sessions']

return {
  ["/oidc/:user/refreshed"] = {
    schema = schema,
    methods = {

      GET = function(self)
        return { status = 200, json = { timestamp = store["renewal_" .. self.params.user] } }
      end,

      POST = function(self)
        store["renewal_" .. self.params.user] = self.params.timestamp
        return { status = 201, json = { success = true } }
      end,

    },
  },
}