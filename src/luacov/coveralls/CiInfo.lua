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
    service_number  = NULL;
    job_id          = "TRAVIS_JOB_ID";
    token           = "COVERALLS_REPO_TOKEN";
    commit_id       = "TRAVIS_COMMIT";
    author_name     = NULL;
    author_email    = NULL;
    committer_name  = NULL;
    committer_email = NULL;
    message         = NULL;
  };

  appveyor = {
    branch          = "APPVEYOR_REPO_BRANCH";
    service_number  = "APPVEYOR_BUILD_NUMBER";
    job_id          = "APPVEYOR_JOB_ID";
    token           = "COVERALLS_REPO_TOKEN";
    commit_id       = "APPVEYOR_REPO_COMMIT";
    author_name     = "APPVEYOR_REPO_COMMIT_AUTHOR";
    author_email    = "APPVEYOR_REPO_COMMIT_AUTHOR_EMAIL";
    committer_name  = NULL;
    committer_email = NULL;
    message         = "APPVEYOR_REPO_COMMIT_MESSAGE";
  };

  codeship = {
    branch          = "CI_BRANCH";
    service_number  = NULL;
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
    service_number  = NULL;
    job_id          = "CIRCLE_BUILD_NUM";
    token           = "COVERALLS_REPO_TOKEN";
    commit_id       = NULL;
    author_name     = NULL;
    author_email    = NULL;
    committer_name  = NULL;
    committer_email = NULL;
    message         = NULL;
  };

  drone = {
    branch          = "DRONE_BRANCH";
    service_number  = NULL;
    job_id          = "DRONE_BUILD_NUMBER";
    token           = "COVERALLS_REPO_TOKEN";
    commit_id       = "DRONE_COMMIT";
    author_name     = NULL;
    author_email    = NULL;
    committer_name  = NULL;
    committer_email = NULL;
    message         = NULL;
  };

}

local function is_ci()
  return ENV.CI and ENV.CI:lower() == "true"
end

local function ci_name()
  if not is_ci() then return end

  if (ENV.TRAVIS   or ''):lower() == "true"     then return "travis-ci" end
  if (ENV.CI_NAME  or ''):lower() == "codeship" then return "codeship"  end
  if (ENV.CIRCLECI or ''):lower() == "true"     then return "circleci"  end
  if (ENV.APPVEYOR or ''):lower() == "true"     then return "appveyor"  end
  if (ENV.DRONE    or ''):lower() == "true"     then return "drone"     end
end

local function cfg()
  local name = ci_name()
  return CI_CONFIG[name] or NULL
end

local function ci_branch         () return ENV[cfg().branch         ] end
local function ci_job_id         () return ENV[cfg().job_id         ] end
local function ci_service_number () return ENV[cfg().service_number ] end
local function ci_token          () return ENV[cfg().token          ] end
local function ci_commit_id      () return ENV[cfg().commit_id      ] end
local function ci_author_name    () return ENV[cfg().author_name    ] end
local function ci_author_email   () return ENV[cfg().author_email   ] end
local function ci_committer_name () return ENV[cfg().committer_name ] end
local function ci_committer_email() return ENV[cfg().committer_email] end
local function ci_message        () return ENV[cfg().message        ] end

return {
  ENV             = ENV;
  name            = ci_name;
  branch          = ci_branch;
  service_number  = ci_service_number;
  job_id          = ci_job_id;
  token           = ci_token;
  commit_id       = ci_commit_id;
  author_name     = ci_author_name;
  author_email    = ci_author_email;
  committer_name  = ci_committer_name;
  committer_email = ci_committer_email;
  message         = ci_message;
}
