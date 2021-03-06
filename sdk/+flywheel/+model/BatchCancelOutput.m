% BatchCancelOutput
%
% BatchCancelOutput Properties:
%    numberCancelled 
%
% BatchCancelOutput Methods:
%    toJson - Convert the object to a Map that can be encoded to json
%    struct - Convert the object to a struct
    classdef BatchCancelOutput < flywheel.ModelBase
    % NOTE: This file is auto generated by the swagger code generator program.
    % Do not edit the file manually.
    properties (Constant)
        propertyMap = containers.Map({ 'numberCancelled' }, ...
            { 'number_cancelled' });
    end
    properties(Dependent)
        numberCancelled
    end
    methods
        function obj = BatchCancelOutput(varargin)
            obj@flywheel.ModelBase(flywheel.model.BatchCancelOutput.propertyMap);

            % Allow empty object creation
            if length(varargin)
                p = inputParser;
                addParameter(p, 'numberCancelled', []);

                parse(p, varargin{:});

                if ~isempty(p.Results.numberCancelled)
                    obj.props_('number_cancelled') = p.Results.numberCancelled;
                end
            end
        end
        function result = get.numberCancelled(obj)
            if ismethod(obj, 'get_numberCancelled')
                result = obj.get_numberCancelled();
            else
                if isKey(obj.props_, 'number_cancelled')
                    result = obj.props_('number_cancelled');
                else
                    result = [];
                end
            end
        end
        function obj = set.numberCancelled(obj, value)
            obj.props_('number_cancelled') = value;
        end
        function result = toJson(obj)
            result = containers.Map;
            if isKey(obj.props_, 'number_cancelled')
                result('number_cancelled') = flywheel.ModelBase.serializeValue(obj.props_('number_cancelled'), 'integer');
            end
        end
        function result = struct(obj)
            result = struct;

            if isKey(obj.props_, 'number_cancelled')
                result.numberCancelled = obj.props_('number_cancelled');
            else
                result.numberCancelled = [];
            end
        end
        function result = returnValue(obj)
            result = obj.props_('number_cancelled');
        end
    end
    methods(Access = protected)
        function prpgrp = getPropertyGroups(obj)
            if ~isscalar(obj)
                prpgrp = getPropertyGroups@matlab.mixin.CustomDisplay(obj);
            else
                propList = struct;
                if isKey(obj.props_, 'number_cancelled')
                    propList.numberCancelled = obj.props_('number_cancelled');
                else
                    propList.numberCancelled = [];
                end
                prpgrp = matlab.mixin.util.PropertyGroup(propList);
            end
        end
    end
    methods(Static)
        function obj = fromJson(json, context)
            obj =  flywheel.model.BatchCancelOutput;
            if isfield(json, 'number_cancelled')
                obj.props_('number_cancelled') = flywheel.ModelBase.deserializeValue(json.number_cancelled, 'integer');
            end
            if isprop(obj, 'context_')
                obj.setContext_(context);
            end
        end
        function obj = ensureIsInstance(obj)
            if ~isempty(obj)
                % Realistically, we only convert structs
                if ~isa(obj, 'flywheel.model.BatchCancelOutput')
                    obj = flywheel.model.BatchCancelOutput(obj);
                end
                if isKey(obj.props_, 'number_cancelled')
                end
            end
        end
    end
end
