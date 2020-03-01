% TreeRequest
%
% TreeRequest Properties:
%    groups       
%    projects     
%    subjects     
%    sessions     
%    acquisitions 
%    analyses     
%    jobs         
%
% TreeRequest Methods:
%    toJson - Convert the object to a Map that can be encoded to json
%    struct - Convert the object to a struct
    classdef TreeRequest < flywheel.ModelBase
    % NOTE: This file is auto generated by the swagger code generator program.
    % Do not edit the file manually.
    properties (Constant)
        propertyMap = containers.Map({ 'groups', 'projects', 'subjects', 'sessions', 'acquisitions', 'analyses', 'jobs' }, ...
            { 'groups', 'projects', 'subjects', 'sessions', 'acquisitions', 'analyses', 'jobs' });
    end
    properties(Dependent)
        groups
        projects
        subjects
        sessions
        acquisitions
        analyses
        jobs
    end
    methods
        function obj = TreeRequest(varargin)
            obj@flywheel.ModelBase(flywheel.model.TreeRequest.propertyMap);

            % Allow empty object creation
            if length(varargin)
                p = inputParser;
                addParameter(p, 'groups', []);
                addParameter(p, 'projects', []);
                addParameter(p, 'subjects', []);
                addParameter(p, 'sessions', []);
                addParameter(p, 'acquisitions', []);
                addParameter(p, 'analyses', []);
                addParameter(p, 'jobs', []);

                parse(p, varargin{:});

                if ~isempty(p.Results.groups)
                    obj.props_('groups') = p.Results.groups;
                end
                if ~isempty(p.Results.projects)
                    obj.props_('projects') = p.Results.projects;
                end
                if ~isempty(p.Results.subjects)
                    obj.props_('subjects') = p.Results.subjects;
                end
                if ~isempty(p.Results.sessions)
                    obj.props_('sessions') = p.Results.sessions;
                end
                if ~isempty(p.Results.acquisitions)
                    obj.props_('acquisitions') = p.Results.acquisitions;
                end
                if ~isempty(p.Results.analyses)
                    obj.props_('analyses') = p.Results.analyses;
                end
                if ~isempty(p.Results.jobs)
                    obj.props_('jobs') = p.Results.jobs;
                end
            end
        end
        function result = get.groups(obj)
            if ismethod(obj, 'get_groups')
                result = obj.get_groups();
            else
                if isKey(obj.props_, 'groups')
                    result = obj.props_('groups');
                else
                    result = [];
                end
            end
        end
        function obj = set.groups(obj, value)
            obj.props_('groups') = value;
        end
        function result = get.projects(obj)
            if ismethod(obj, 'get_projects')
                result = obj.get_projects();
            else
                if isKey(obj.props_, 'projects')
                    result = obj.props_('projects');
                else
                    result = [];
                end
            end
        end
        function obj = set.projects(obj, value)
            obj.props_('projects') = value;
        end
        function result = get.subjects(obj)
            if ismethod(obj, 'get_subjects')
                result = obj.get_subjects();
            else
                if isKey(obj.props_, 'subjects')
                    result = obj.props_('subjects');
                else
                    result = [];
                end
            end
        end
        function obj = set.subjects(obj, value)
            obj.props_('subjects') = value;
        end
        function result = get.sessions(obj)
            if ismethod(obj, 'get_sessions')
                result = obj.get_sessions();
            else
                if isKey(obj.props_, 'sessions')
                    result = obj.props_('sessions');
                else
                    result = [];
                end
            end
        end
        function obj = set.sessions(obj, value)
            obj.props_('sessions') = value;
        end
        function result = get.acquisitions(obj)
            if ismethod(obj, 'get_acquisitions')
                result = obj.get_acquisitions();
            else
                if isKey(obj.props_, 'acquisitions')
                    result = obj.props_('acquisitions');
                else
                    result = [];
                end
            end
        end
        function obj = set.acquisitions(obj, value)
            obj.props_('acquisitions') = value;
        end
        function result = get.analyses(obj)
            if ismethod(obj, 'get_analyses')
                result = obj.get_analyses();
            else
                if isKey(obj.props_, 'analyses')
                    result = obj.props_('analyses');
                else
                    result = [];
                end
            end
        end
        function obj = set.analyses(obj, value)
            obj.props_('analyses') = value;
        end
        function result = get.jobs(obj)
            if ismethod(obj, 'get_jobs')
                result = obj.get_jobs();
            else
                if isKey(obj.props_, 'jobs')
                    result = obj.props_('jobs');
                else
                    result = [];
                end
            end
        end
        function obj = set.jobs(obj, value)
            obj.props_('jobs') = value;
        end
        function result = toJson(obj)
            result = containers.Map;
            if isKey(obj.props_, 'groups')
                result('groups') = obj.props_('groups').toJson();
            end
            if isKey(obj.props_, 'projects')
                result('projects') = obj.props_('projects').toJson();
            end
            if isKey(obj.props_, 'subjects')
                result('subjects') = obj.props_('subjects').toJson();
            end
            if isKey(obj.props_, 'sessions')
                result('sessions') = obj.props_('sessions').toJson();
            end
            if isKey(obj.props_, 'acquisitions')
                result('acquisitions') = obj.props_('acquisitions').toJson();
            end
            if isKey(obj.props_, 'analyses')
                result('analyses') = obj.props_('analyses').toJson();
            end
            if isKey(obj.props_, 'jobs')
                result('jobs') = obj.props_('jobs').toJson();
            end
        end
        function result = struct(obj)
            result = struct;

            if isKey(obj.props_, 'groups')
                result.groups = struct(obj.props_('groups'));
            else
                result.groups = [];
            end
            if isKey(obj.props_, 'projects')
                result.projects = struct(obj.props_('projects'));
            else
                result.projects = [];
            end
            if isKey(obj.props_, 'subjects')
                result.subjects = struct(obj.props_('subjects'));
            else
                result.subjects = [];
            end
            if isKey(obj.props_, 'sessions')
                result.sessions = struct(obj.props_('sessions'));
            else
                result.sessions = [];
            end
            if isKey(obj.props_, 'acquisitions')
                result.acquisitions = struct(obj.props_('acquisitions'));
            else
                result.acquisitions = [];
            end
            if isKey(obj.props_, 'analyses')
                result.analyses = struct(obj.props_('analyses'));
            else
                result.analyses = [];
            end
            if isKey(obj.props_, 'jobs')
                result.jobs = struct(obj.props_('jobs'));
            else
                result.jobs = [];
            end
        end
        function result = returnValue(obj)
            result = obj;
        end
    end
    methods(Access = protected)
        function prpgrp = getPropertyGroups(obj)
            if ~isscalar(obj)
                prpgrp = getPropertyGroups@matlab.mixin.CustomDisplay(obj);
            else
                propList = struct;
                if isKey(obj.props_, 'groups')
                    propList.groups = obj.props_('groups');
                else
                    propList.groups = [];
                end
                if isKey(obj.props_, 'projects')
                    propList.projects = obj.props_('projects');
                else
                    propList.projects = [];
                end
                if isKey(obj.props_, 'subjects')
                    propList.subjects = obj.props_('subjects');
                else
                    propList.subjects = [];
                end
                if isKey(obj.props_, 'sessions')
                    propList.sessions = obj.props_('sessions');
                else
                    propList.sessions = [];
                end
                if isKey(obj.props_, 'acquisitions')
                    propList.acquisitions = obj.props_('acquisitions');
                else
                    propList.acquisitions = [];
                end
                if isKey(obj.props_, 'analyses')
                    propList.analyses = obj.props_('analyses');
                else
                    propList.analyses = [];
                end
                if isKey(obj.props_, 'jobs')
                    propList.jobs = obj.props_('jobs');
                else
                    propList.jobs = [];
                end
                prpgrp = matlab.mixin.util.PropertyGroup(propList);
            end
        end
    end
    methods(Static)
        function obj = fromJson(json, context)
            obj =  flywheel.model.TreeRequest;
            if isfield(json, 'groups')
                obj.props_('groups') = flywheel.model.TreeContainerRequestSpec.fromJson(json.groups, context);
            end
            if isfield(json, 'projects')
                obj.props_('projects') = flywheel.model.TreeContainerRequestSpec.fromJson(json.projects, context);
            end
            if isfield(json, 'subjects')
                obj.props_('subjects') = flywheel.model.TreeContainerRequestSpec.fromJson(json.subjects, context);
            end
            if isfield(json, 'sessions')
                obj.props_('sessions') = flywheel.model.TreeContainerRequestSpec.fromJson(json.sessions, context);
            end
            if isfield(json, 'acquisitions')
                obj.props_('acquisitions') = flywheel.model.TreeContainerRequestSpec.fromJson(json.acquisitions, context);
            end
            if isfield(json, 'analyses')
                obj.props_('analyses') = flywheel.model.TreeContainerRequestSpec.fromJson(json.analyses, context);
            end
            if isfield(json, 'jobs')
                obj.props_('jobs') = flywheel.model.TreeContainerRequestSpec.fromJson(json.jobs, context);
            end
            if isprop(obj, 'context_')
                obj.setContext_(context);
            end
        end
        function obj = ensureIsInstance(obj)
            if ~isempty(obj)
                % Realistically, we only convert structs
                if ~isa(obj, 'flywheel.model.TreeRequest')
                    obj = flywheel.model.TreeRequest(obj);
                end
                if isKey(obj.props_, 'groups')
                    obj.props_('groups') =  flywheel.model.TreeContainerRequestSpec.ensureIsInstance(obj.props_('groups'));
                end
                if isKey(obj.props_, 'projects')
                    obj.props_('projects') =  flywheel.model.TreeContainerRequestSpec.ensureIsInstance(obj.props_('projects'));
                end
                if isKey(obj.props_, 'subjects')
                    obj.props_('subjects') =  flywheel.model.TreeContainerRequestSpec.ensureIsInstance(obj.props_('subjects'));
                end
                if isKey(obj.props_, 'sessions')
                    obj.props_('sessions') =  flywheel.model.TreeContainerRequestSpec.ensureIsInstance(obj.props_('sessions'));
                end
                if isKey(obj.props_, 'acquisitions')
                    obj.props_('acquisitions') =  flywheel.model.TreeContainerRequestSpec.ensureIsInstance(obj.props_('acquisitions'));
                end
                if isKey(obj.props_, 'analyses')
                    obj.props_('analyses') =  flywheel.model.TreeContainerRequestSpec.ensureIsInstance(obj.props_('analyses'));
                end
                if isKey(obj.props_, 'jobs')
                    obj.props_('jobs') =  flywheel.model.TreeContainerRequestSpec.ensureIsInstance(obj.props_('jobs'));
                end
            end
        end
    end
end