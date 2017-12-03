# TODO: Move this stuff and all Recast functionality to its own package.
struct Action
  JSON.mapping(
    slug: {type: String, nilable: true},
    done: {type: Bool, nilable: true},
    reply: {type: String, nilable: true}
  )
end

struct Results
  JSON.mapping(
    action: {type: Action, nilable: true},
    replies: {type: Array(String), nilable: true},
    conversation_token: {type: String, nilable: true}
  )
end

struct Response
  JSON.mapping(
    results: {type: Results, nilable: false}
  )
end
