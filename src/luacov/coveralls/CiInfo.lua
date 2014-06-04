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
    branch = "TRAVIS_BRANCH";
    job_id = "TRAVIS_JOB_ID";
    token  = "COVERALLS_REPO_TOKEN";
  };
  codeship = {
    branch = "CI_BRANCH";
    job_id = "CI_BUILD_NUMBER";
    token  = "COVERALLS_REPO_TOKEN";
  };
  circleci = {
    branch = "CIRCLE_BUILD_NUM";
    job_id = "CIRCLE_BUILD_NUM";
    token  = "COVERALLS_REPO_TOKEN";
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

local function ci_branch()
  return ENV[cfg().branch]
end

local function ci_job_id()
  return ENV[cfg().job_id]
end

local function ci_token()
  return ENV[cfg().token]
end

return {
  name   = ci_name;
  branch = ci_branch;
  job_id = ci_job_id;
  token  = ci_token;
}
