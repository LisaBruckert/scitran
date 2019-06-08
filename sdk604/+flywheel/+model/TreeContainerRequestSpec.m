% TreeContainerRequestSpec
%
% TreeContainerRequestSpec Properties:
%    fields  - The list of fields to include
%    filter  - The optional, comma-separated filter string
%    limit   - The optional maximum number of children to include
%    sort    - The optional, comma-separated, sort specification
%
% TreeContainerRequestSpec Methods:
%    toJson - Convert the object to a Map that can be encoded to json
%    struct - Convert the object to a struct
    classdef TreeContainerRequestSpec < flywheel.ModelBase
    % NOTE: This file is auto generated by the swagger code generator program.
    % Do not edit the file manually.
    properties (Constant)
        propertyMap = containers.Map({ 'fields', 'filter', 'limit', 'sort' }, ...
            { 'fields', 'filter', 'limit', 'sort' });
    end
    properties(Dependent)
        fields
        filter
        limit
        sort
    end
    methods
        function obj = TreeContainerRequestSpec(varargin)
            obj@flywheel.ModelBase(flywheel.model.TreeContainerRequestSpec.propertyMap);

            % Allow empty object creation
            if length(varargin)
                p = inputParser;
                addParameter(p, 'fields', []);
                addParameter(p, 'filter', []);
                addParameter(p, 'limit', []);
                addParameter(p, 'sort', []);

                parse(p, varargin{:});

                if ~isempty(p.Results.fields)
                    obj.props_('fields') = p.Results.fields;
                end
                if ~isempty(p.Results.filter)
                    obj.props_('filter') = p.Results.filter;
                end
                if ~isempty(p.Results.limit)
                    obj.props_('limit') = p.Results.limit;
                end
                if ~isempty(p.Results.sort)
                    obj.props_('sort') = p.Results.sort;
                end
            end
        end
        function result = get.fields(obj)
            if ismethod(obj, 'get_fields')
                result = obj.get_fields();
            else
                if isKey(obj.props_, 'fields')
                    result = obj.props_('fields');
                else
                    result = [];
                end
            end
        end
        function obj = set.fields(obj, value)
            obj.props_('fields') = value;
        end
        function result = get.filter(obj)
            if ismethod(obj, 'get_filter')
                result = obj.get_filter();
            else
                if isKey(obj.props_, 'filter')
                    result = obj.props_('filter');
                else
                    result = [];
                end
            end
        end
        function obj = set.filter(obj, value)
            obj.props_('filter') = value;
        end
        function result = get.limit(obj)
            if ismethod(obj, 'get_limit')
                result = obj.get_limit();
            else
                if isKey(obj.props_, 'limit')
                    result = obj.props_('limit');
                else
                    result = [];
                end
            end
        end
        function obj = set.limit(obj, value)
            obj.props_('limit') = value;
        end
        function result = get.sort(obj)
            if ismethod(obj, 'get_sort')
                result = obj.get_sort();
            else
                if isKey(obj.props_, 'sort')
                    result = obj.props_('sort');
                else
                    result = [];
                end
            end
        end
        function obj = set.sort(obj, value)
            obj.props_('sort') = value;
        end
        function result = toJson(obj)
            result = containers.Map;
            if isKey(obj.props_, 'fields')
                result('fields') = flywheel.ModelBase.serializeValue(obj.props_('fields'), 'vector[char]');
            end
            if isKey(obj.props_, 'filter')
                result('filter') = flywheel.ModelBase.serializeValue(obj.props_('filter'), 'char');
            end
            if isKey(obj.props_, 'limit')
                result('limit') = flywheel.ModelBase.serializeValue(obj.props_('limit'), 'integer');
            end
            if isKey(obj.props_, 'sort')
                result('sort') = flywheel.ModelBase.serializeValue(obj.props_('sort'), 'char');
            end
        end
        function result = struct(obj)
            result = struct;

            if isKey(obj.props_, 'fields')
                result.fields = obj.props_('fields');
            else
                result.fields = [];
            end
            if isKey(obj.props_, 'filter')
                result.filter = obj.props_('filter');
            else
                result.filter = [];
            end
            if isKey(obj.props_, 'limit')
                result.limit = obj.props_('limit');
            else
                result.limit = [];
            end
            if isKey(obj.props_, 'sort')
                result.sort = obj.props_('sort');
            else
                result.sort = [];
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
                if isKey(obj.props_, 'fields')
                    propList.fields = obj.props_('fields');
                else
                    propList.fields = [];
                end
                if isKey(obj.props_, 'filter')
                    propList.filter = obj.props_('filter');
                else
                    propList.filter = [];
                end
                if isKey(obj.props_, 'limit')
                    propList.limit = obj.props_('limit');
                else
                    propList.limit = [];
                end
                if isKey(obj.props_, 'sort')
                    propList.sort = obj.props_('sort');
                else
                    propList.sort = [];
                end
                prpgrp = matlab.mixin.util.PropertyGroup(propList);
            end
        end
    end
    methods(Static)
        function obj = fromJson(json, context)
            obj =  flywheel.model.TreeContainerRequestSpec;
            if isfield(json, 'fields')
                obj.props_('fields') = flywheel.ModelBase.deserializeValue(json.fields, 'vector[char]');
            end
            if isfield(json, 'filter')
                obj.props_('filter') = flywheel.ModelBase.deserializeValue(json.filter, 'char');
            end
            if isfield(json, 'limit')
                obj.props_('limit') = flywheel.ModelBase.deserializeValue(json.limit, 'integer');
            end
            if isfield(json, 'sort')
                obj.props_('sort') = flywheel.ModelBase.deserializeValue(json.sort, 'char');
            end
            if isprop(obj, 'context_')
                obj.setContext_(context);
            end
        end
        function obj = ensureIsInstance(obj)
            if ~isempty(obj)
                % Realistically, we only convert structs
                if ~isa(obj, 'flywheel.model.TreeContainerRequestSpec')
                    obj = flywheel.model.TreeContainerRequestSpec(obj);
                end
                if isKey(obj.props_, 'fields')
                end
                if isKey(obj.props_, 'filter')
                end
                if isKey(obj.props_, 'limit')
                end
                if isKey(obj.props_, 'sort')
                end
            end
        end
    end
end
