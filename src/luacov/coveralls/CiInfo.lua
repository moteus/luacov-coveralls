local NULL = {}
setmetatable(NULL, {__index = function() return NULL end})

local function env(_, name)
  if name == NULL then return nil end

  local v = os.getenv(name)
  if v == "" then return nil end
  return v
end

local ENV = setmetatable({}, {__index = env})

local CI_CONFIG = {
  ["travis-ci"] = {
    branch          = "TRAVIS_BRANCH";
    job_id          = "TRAVIS_JOB_ID";
    token           = "COVERALLS_REPO_TOKEN";
    commit_id       = "TRAVIS_COMMIT";
    author_name     = NULL;
    author_email    = NULL;
    committer_name  = NULL;
    committer_email = NULL;
    message         = NULL;
  };

  codeship = {
    branch          = "CI_BRANCH";
    job_id          = "CI_BUILD_NUMBER";
    token           = "COVERALLS_REPO_TOKEN";
    commit_id       = "CI_COMMIT_ID";
    author_name     = NULL;
    author_email    = NULL;
    committer_name  = "CI_COMMITTER_NAME";
    committer_email = "CI_COMMITTER_EMAIL";
    message         = "CI_MESSAGE";
  };

  circleci = {
    branch          = "CIRCLE_BRANCH";
    job_id          = "CIRCLE_BUILD_NUM";
    token           = "COVERALLS_REPO_TOKEN";
    commit_id       = NULL;
    author_name     = NULL;
    author_email    = NULL;
    committer_name  = NULL;
    committer_email = NULL;
    message         = NULL;
  };
}

local function is_ci()
  return ENV.CI == "true"
end

local function ci_name()
  if not is_ci() then return end
  if ENV.TRAVIS   == "true"     then return "travis-ci" end
  if ENV.CI_NAME  == "codeship" then return "codeship"  end
  if ENV.CIRCLECI == "true"     then return "circleci"  end
end

local function cfg()
  local name = ci_name()
  return CI_CONFIG[name] or NULL
end

local function ci_branch         () return ENV[cfg().branch         ] end
local function ci_job_id         () return ENV[cfg().job_id         ] end
local function ci_token          () return ENV[cfg().token          ] end
local function ci_commit_id      () return ENV[cfg().commit_id      ] end
local function ci_author_name    () return ENV[cfg().author_name    ] end
local function ci_author_email   () return ENV[cfg().author_email   ] end
local function ci_committer_name () return ENV[cfg().committer_name ] end
local function ci_committer_email() return ENV[cfg().committer_email] end
local function ci_message        () return ENV[cfg().message        ] end

return {
  name            = ci_name;
  branch          = ci_branch;
  job_id          = ci_job_id;
  token           = ci_token;
  commit_id       = ci_commit_id;
  author_name     = ci_author_name;
  author_email    = ci_author_email;
  committer_name  = ci_committer_name;
  committer_email = ci_committer_email;
  message         = ci_message;
}
