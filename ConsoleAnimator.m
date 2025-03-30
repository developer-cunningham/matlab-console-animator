classdef ConsoleAnimator < handle
    % ConsoleAnimator
    % This class creates a simple console-based animation by cycling through
    % a set of frames at a fixed rate. The animation runs in the background
    % using a MATLAB timer object.
    
    properties
        framesCellArray        % Cell array containing the animation frames
        stopFlag = false       % Flag to control animation stopping
        prevStr = ''           % Stores the previous frame string for cleanup
        animationTimer         % MATLAB timer object for handling animation
        currentFrameIndex = 1  % Index of the current frame
    end
    
    methods
        function obj = ConsoleAnimator(framesCellArray)
            % ConsoleAnimator Constructor
            % Initializes the animation with the given frames.
            %
            % Parameters:
            %   framesCellArray (cell array): Array of strings representing animation frames.
            %
            % Example Usage:
            %   animator = ConsoleAnimator({'.', '..', '...', '..'});
            obj.framesCellArray = framesCellArray;
            obj.stopFlag = false; % Reset stop flag on new instance
        end
        
        function start(obj)
            % START Starts the animation.
            %
            % If a previous animation is running, it ensures cleanup before starting a new one.
            %
            % Example Usage:
            %   animator.start();
            
            obj.stopFlag = false; % Ensure animation can run
            
            % Cleanup previous timer if it exists
            if ~isempty(obj.animationTimer) && isvalid(obj.animationTimer)
                stop(obj.animationTimer);
                delete(obj.animationTimer);
            end
            
            % Create and start a new timer for the animation
            obj.animationTimer = timer( ...
                'ExecutionMode', 'fixedRate', ...
                'Period', 0.1, ... % Adjust period to control animation speed
                'TimerFcn', @(~, ~) obj.animate(), ...
                'StartDelay', 0);
            start(obj.animationTimer);
        end
        
        function animate(obj)
            % ANIMATE Handles the frame updating for the animation.
            %
            % This function is called by the timer at each interval.
            % It updates the console with the current frame and clears the previous frame.
            
            if obj.stopFlag
                return;
            end
            
            % Get the current frame
            currStr = sprintf('Loading: %-10s', obj.framesCellArray{obj.currentFrameIndex});
            
            % Clear previous frame output in console
            if ~isempty(obj.prevStr)
                fprintf(repmat('\b', 1, length(obj.prevStr)));
            end
            
            % Print the current frame
            fprintf('%s', currStr);
            obj.prevStr = currStr;
            
            % Update frame index cyclically
            obj.currentFrameIndex = mod(obj.currentFrameIndex, length(obj.framesCellArray)) + 1;
        end
        
        function stopAnimator(obj)
            % STOPANIMATOR Stops the animation and cleans up resources.
            %
            % This function stops the timer, deletes it, and resets all properties
            % to ensure a fresh start when restarted.
            %
            % Example Usage:
            %   animator.stopAnimator();
            
            obj.stopFlag = true; % Stop animation loop
            
            % Ensure the timer is stopped and deleted
            if ~isempty(obj.animationTimer) && isvalid(obj.animationTimer)
                stop(obj.animationTimer);
                delete(obj.animationTimer);
            end
            
            % Reset all properties for full cleanup
            obj.framesCellArray = {}; % Clear frames
            obj.prevStr = ''; % Reset previous frame string
            obj.currentFrameIndex = 1; % Reset frame index
        end
    end
end
