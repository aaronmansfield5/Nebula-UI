local Library = {}
Library.__index = Library

local platform
local sections = {}
local pages = {}

local TweenService = game:GetService("TweenService")

local function getPlatform()
	local UserInputService = game:GetService("UserInputService")
	return UserInputService.TouchEnabled and "Mobile" or "PC"
end

function Library.init(args)
	if not game:IsLoaded() or not game:GetService("Players").LocalPlayer then
		error("init can only be run from the client")
	end

	local self = setmetatable({}, Library)
	platform = getPlatform()

	local player = game.Players.LocalPlayer
	local screenGui = Instance.new("ScreenGui")
	screenGui.Parent = game:GetService("CoreGui")

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 600, 0, 300)
	mainFrame.Position = UDim2.new(0.5, -300, 0.5, -150)
	mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	mainFrame.BorderSizePixel = 0
	mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	mainFrame.Parent = screenGui

	local mainCorner = Instance.new("UICorner")
	mainCorner.CornerRadius = UDim.new(0, 10)
	mainCorner.Parent = mainFrame

	local sidebarFrame = Instance.new("Frame")
	sidebarFrame.Size = UDim2.new(0, 150, 1, 0)
	sidebarFrame.Position = UDim2.new(0, 0, 0, 0)
	sidebarFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	sidebarFrame.BorderSizePixel = 0
	sidebarFrame.Parent = mainFrame

	local sidebarCorner = Instance.new("UICorner")
	sidebarCorner.CornerRadius = UDim.new(0, 10)
	sidebarCorner.Parent = sidebarFrame

	local topImage = Instance.new("ImageLabel")
	topImage.Size = UDim2.new(1, 0, 0, 60)
	topImage.Position = UDim2.new(0, 0, 0, 5)
	topImage.BackgroundTransparency = 1
	topImage.Image = "rbxassetid://"..args.ImageId
	topImage.Parent = sidebarFrame
	topImage.ScaleType = Enum.ScaleType.Fit

	local sidebar = Instance.new("ScrollingFrame")
	sidebar.Size = UDim2.new(1, 0, 1, -140)
	sidebar.Position = UDim2.new(0, 0, 0, 60)
	sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
	sidebar.ScrollBarThickness = 0
	sidebar.BackgroundTransparency = 1
	sidebar.BorderSizePixel = 0
	sidebar.ClipsDescendants = true
	sidebar.Parent = sidebarFrame

	local sidebarPadding = Instance.new("UIPadding")
	sidebarPadding.PaddingTop = UDim.new(0, 10)
	sidebarPadding.PaddingBottom = UDim.new(0, 10)
	sidebarPadding.PaddingLeft = UDim.new(0, 10)
	sidebarPadding.PaddingRight = UDim.new(0, 10)
	sidebarPadding.Parent = sidebar

	local sidebarLayout = Instance.new("UIListLayout")
	sidebarLayout.Parent = sidebar
	sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
	sidebarLayout.Padding = UDim.new(0, 5)

	local function updateCanvasSize()
		sidebar.CanvasSize = UDim2.new(0, 0, 0, sidebarLayout.AbsoluteContentSize.Y + sidebarPadding.PaddingTop.Offset + sidebarPadding.PaddingBottom.Offset)
	end

	local playerFrame = Instance.new("Frame")
	playerFrame.Size = UDim2.new(0.9, 0, 0, 50)
	playerFrame.Position = UDim2.new(0.05, 0, 1, -60)
	playerFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	playerFrame.BorderSizePixel = 0
	playerFrame.ClipsDescendants = true
	playerFrame.Parent = sidebarFrame

	local playerFrameCorner = Instance.new("UICorner")
	playerFrameCorner.CornerRadius = UDim.new(0, 8)
	playerFrameCorner.Parent = playerFrame

	local playerImage = Instance.new("ImageLabel")
	playerImage.Size = UDim2.new(0, 30, 0, 30)
	playerImage.Position = UDim2.new(0, 10, 0.5, 0)
	playerImage.AnchorPoint = Vector2.new(0, 0.5)
	playerImage.BackgroundTransparency = 1
	playerImage.Parent = playerFrame

	local playerCorner = Instance.new("UICorner")
	playerCorner.CornerRadius = UDim.new(1, 0)
	playerCorner.Parent = playerImage

	local outerFrame = Instance.new("Frame")
	outerFrame.Size = UDim2.new(0, 36, 0, 36)
	outerFrame.Position = UDim2.new(0, 7, 0.5, 0)
	outerFrame.AnchorPoint = Vector2.new(0, 0.5)
	outerFrame.BackgroundTransparency = 1
	outerFrame.Parent = playerFrame
	
	local outerCorner = Instance.new("UICorner")
	outerCorner.CornerRadius = UDim.new(1, 0)
	outerCorner.Parent = outerFrame

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromHex(args.PrimaryColour)
	stroke.Thickness = 1
	stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	stroke.Parent = outerFrame

	local thumbType = Enum.ThumbnailType.HeadShot
	local thumbSize = Enum.ThumbnailSize.Size180x180
	local content, isReady = game.Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
	playerImage.Image = content

	local playerName = Instance.new("TextLabel")
	playerName.Size = UDim2.new(1, -50, 0.5, 0)
	playerName.Position = UDim2.new(0, 50, 0, 5)
	playerName.BackgroundTransparency = 1
	playerName.Text = player.DisplayName
	playerName.TextColor3 = Color3.fromRGB(255, 255, 255)
	playerName.Font = Enum.Font.GothamBold
	playerName.TextSize = 14
	playerName.TextXAlignment = Enum.TextXAlignment.Left
	playerName.Parent = playerFrame

	local playerStatus = Instance.new("TextLabel")
	playerStatus.Size = UDim2.new(1, -50, 0.5, 0)
	playerStatus.Position = UDim2.new(0, 50, 0.5, -5)
	playerStatus.BackgroundTransparency = 1
	playerStatus.Text = "Member"
	playerStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
	playerStatus.Font = Enum.Font.GothamBold
	playerStatus.TextSize = 12
	playerStatus.TextXAlignment = Enum.TextXAlignment.Left
	playerStatus.Parent = playerFrame
	
	local statusGradient = Instance.new("UIGradient")
	statusGradient.Color = ColorSequence.new(Color3.fromHex(args.PrimaryColour), Color3.fromRGB(255, 255, 255))
	statusGradient.Parent = playerStatus


	local contentFrame = Instance.new("Frame")
	contentFrame.Size = UDim2.new(1, -150, 1, 0)
	contentFrame.Position = UDim2.new(0, 150, 0, 0)
	contentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	contentFrame.BorderSizePixel = 0
	contentFrame.Parent = mainFrame
	
	local contentGradient = Instance.new("UIGradient")
	contentGradient.Color = ColorSequence.new(Color3.fromRGB(25, 25, 25), Color3.fromHex(args.PrimaryColour))
	contentGradient.Parent = contentFrame

	local contentCorner = Instance.new("UICorner")
	contentCorner.CornerRadius = UDim.new(0, 10)
	contentCorner.Parent = contentFrame

	local contentLayout = Instance.new("UIListLayout")
	contentLayout.Parent = contentFrame
	contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	contentLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	contentLayout.Padding = UDim.new(0, 5)

	local dragging, dragInput, dragStart, startPos

	local function update(input)
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end

	topImage.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = mainFrame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	topImage.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			update(input)
		end
	end)

	local function createBackdrop(parent)
		local backdrop = Instance.new("Frame")
		backdrop.Size = UDim2.new(1, -20, 0, 50)
		backdrop.Position = UDim2.new(0, 10, 0, 10)
		backdrop.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		backdrop.BorderSizePixel = 0
		backdrop.Parent = parent

		local backdropCorner = Instance.new("UICorner")
		backdropCorner.CornerRadius = UDim.new(0, 8)
		backdropCorner.Parent = backdrop

		return backdrop
	end

	local function createSectionMethods(page)
		local sectionMethods = {}

		function sectionMethods.addTextInput(titleText, placeholderText, callback)
			local backdrop = createBackdrop(page)

			local titleLabel = Instance.new("TextLabel")
			titleLabel.Size = UDim2.new(0.6, -10, 0, 20)
			titleLabel.Position = UDim2.new(0, 10, 0.5, 0)
			titleLabel.AnchorPoint = Vector2.new(0, 0.5)
			titleLabel.BackgroundTransparency = 1
			titleLabel.Text = titleText
			titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			titleLabel.Font = Enum.Font.Gotham
			titleLabel.TextSize = 14
			titleLabel.TextXAlignment = Enum.TextXAlignment.Left
			titleLabel.Parent = backdrop

			local textBox = Instance.new("TextBox")
			textBox.Size = UDim2.new(0.3, -10, 0, 20)
			textBox.Position = UDim2.new(1, -10, 0.5, 0)
			textBox.AnchorPoint = Vector2.new(1, 0.5)
			textBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			textBox.Text = ""
			textBox.PlaceholderText = placeholderText
			textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			textBox.Font = Enum.Font.Gotham
			textBox.TextSize = 14
			textBox.TextXAlignment = Enum.TextXAlignment.Center
			textBox.ClipsDescendants = true
			textBox.Parent = backdrop

			local textBoxCorner = Instance.new("UICorner")
			textBoxCorner.CornerRadius = UDim.new(0, 8)
			textBoxCorner.Parent = textBox

			if callback then
				textBox:GetPropertyChangedSignal("Text"):Connect(function()
					callback(textBox.Text)
				end)
			end

			return textBox
		end

		function sectionMethods.addToggle(labelText, defaultValue, callback)
			local backdrop = createBackdrop(page)

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.6, -10, 1, 0)
			label.Position = UDim2.new(0, 10, 0, 0)
			label.BackgroundTransparency = 1
			label.Text = labelText
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.Font = Enum.Font.Gotham
			label.TextSize = 14
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = backdrop

			local switch = Instance.new("TextButton")
			switch.Size = UDim2.new(0, 20, 0, 20)
			switch.Position = UDim2.new(1, -10, 0.5, 0)
			switch.AnchorPoint = Vector2.new(1, 0.5)
			switch.BackgroundColor3 = defaultValue and Color3.fromHex(args.PrimaryColour) or Color3.fromRGB(60, 60, 60)
			switch.Text = ""
			switch.Parent = backdrop

			local switchCorner = Instance.new("UICorner")
			switchCorner.CornerRadius = UDim.new(0, 8)
			switchCorner.Parent = switch

			local onColor = {BackgroundColor3 = Color3.fromHex(args.PrimaryColour)}
			local offColor = {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}
			local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

			local tweenOn = TweenService:Create(switch, tweenInfo, onColor)
			local tweenOff = TweenService:Create(switch, tweenInfo, offColor)

			switch.MouseButton1Click:Connect(function()
				defaultValue = not defaultValue
				if defaultValue then
					tweenOn:Play()
				else
					tweenOff:Play()
				end
				if callback then
					callback(defaultValue)
				end
			end)

			backdrop.Size = UDim2.new(1, -20, 0, 40)

			return switch
		end

		function sectionMethods.addSlider(labelText, minValue, maxValue, defaultValue, callback)
			local backdrop = createBackdrop(page)

			local sliderLabel = Instance.new("TextLabel")
			sliderLabel.Size = UDim2.new(0.5, -10, 1, 0)
			sliderLabel.Position = UDim2.new(0, 10, 0.5, 0)
			sliderLabel.AnchorPoint = Vector2.new(0, 0.5)
			sliderLabel.BackgroundTransparency = 1
			sliderLabel.Text = labelText
			sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			sliderLabel.Font = Enum.Font.Gotham
			sliderLabel.TextSize = 14
			sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			sliderLabel.Parent = backdrop

			local sliderBar = Instance.new("Frame")
			sliderBar.Size = UDim2.new(0.4, -10, 0, 3)
			sliderBar.Position = UDim2.new(0.6, 0, 0.5, 0)
			sliderBar.AnchorPoint = Vector2.new(0, 0.5)
			sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			sliderBar.Parent = backdrop

			local barCorner = Instance.new("UICorner")
			barCorner.CornerRadius = UDim.new(1, 0)
			barCorner.Parent = sliderBar

			local sliderKnob = Instance.new("ImageButton")
			sliderKnob.Size = UDim2.new(0, 15, 0, 15)
			sliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
			local initialPosition = (defaultValue - minValue) / (maxValue - minValue)
			sliderKnob.Position = UDim2.new(initialPosition, 0, 0.5, 0)
			sliderKnob.BackgroundColor3 = Color3.fromHex(args.PrimaryColour)
			sliderKnob.Image = ""
			sliderKnob.Parent = sliderBar

			local knobCorner = Instance.new("UICorner")
			knobCorner.CornerRadius = UDim.new(1, 0)
			knobCorner.Parent = sliderKnob

			local valueLabel = Instance.new("TextLabel")
			valueLabel.Size = UDim2.new(0, 40, 0, 20)
			valueLabel.Position = UDim2.new(0.5, 0, -0.65, 0)
			valueLabel.AnchorPoint = Vector2.new(0.5, 0)
			valueLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			valueLabel.Font = Enum.Font.Gotham
			valueLabel.TextSize = 14
			valueLabel.Text = tostring(math.round(defaultValue)).."/"..maxValue
			valueLabel.Visible = false
			valueLabel.Parent = sliderKnob

			local labelCorner = Instance.new("UICorner")
			labelCorner.CornerRadius = UDim.new(0, 5)
			labelCorner.Parent = valueLabel

			local dragging = false
			sliderKnob.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				elseif input.UserInputType == Enum.UserInputType.MouseMovement then
					valueLabel.Visible = true
				end
			end)

			sliderKnob.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				elseif input.UserInputType == Enum.UserInputType.MouseMovement then
					valueLabel.Visible = false
				end
			end)

			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local relativeX = input.Position.X - sliderBar.AbsolutePosition.X
					local relativePos = math.clamp(relativeX, 0, sliderBar.AbsoluteSize.X)
					local knobPosition = relativePos / sliderBar.AbsoluteSize.X
					sliderKnob.Position = UDim2.new(knobPosition, 0, 0.5, 0)
					local value = minValue + knobPosition * (maxValue - minValue)
					value = math.round(value)
					valueLabel.Text = tostring(value).."/"..maxValue
					if callback then
						callback(value)
					end
				end
			end)

			backdrop.Size = UDim2.new(1, -20, 0, 40)

			return sliderKnob
		end

		function sectionMethods.addParagraph(text)
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, -20, 0, 0)
			textLabel.Position = UDim2.new(0, 10, 0, 10)
			textLabel.BackgroundTransparency = 1
			textLabel.Text = text
			textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			textLabel.Font = Enum.Font.Gotham
			textLabel.TextSize = 14
			textLabel.TextWrapped = true
			textLabel.TextYAlignment = Enum.TextYAlignment.Top
			textLabel.Parent = page
			textLabel.AutomaticSize = Enum.AutomaticSize.Y

			return textLabel
		end

		function sectionMethods.addDropdownSection(sectionName)
			local dropdownFrame = Instance.new("Frame")
			dropdownFrame.BackgroundTransparency = 1
			dropdownFrame.Size = UDim2.new(0.9, 0, 0, 40)
			dropdownFrame.ClipsDescendants = false
			dropdownFrame.Parent = page

			local backdrop = Instance.new("Frame")
			backdrop.Size = UDim2.new(1, 0, 1, 0)
			backdrop.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			backdrop.BorderSizePixel = 0
			backdrop.ClipsDescendants = false
			backdrop.Parent = dropdownFrame

			local backdropCorner = Instance.new("UICorner")
			backdropCorner.CornerRadius = UDim.new(0, 8)
			backdropCorner.Parent = backdrop

			local dropdownButton = Instance.new("TextButton")
			dropdownButton.Size = UDim2.new(1, 0, 0, 40)
			dropdownButton.BackgroundTransparency = 1
			dropdownButton.Text = ""
			dropdownButton.Parent = backdrop

			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0.9, -10, 1, 0)
			label.Position = UDim2.new(0, 10, 0, 0)
			label.AnchorPoint = Vector2.new(0, 0)
			label.BackgroundTransparency = 1
			label.Text = sectionName
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.Font = Enum.Font.GothamBold
			label.TextSize = 16
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.Parent = dropdownButton

			local dropdownIcon = Instance.new("ImageLabel")
			dropdownIcon.Size = UDim2.new(0, 20, 0, 20)
			dropdownIcon.Position = UDim2.new(1, -30, 0.5, 0)
			dropdownIcon.AnchorPoint = Vector2.new(1, 0.5)
			dropdownIcon.BackgroundTransparency = 1
			dropdownIcon.Image = "http://www.roblox.com/asset/?id=10802182802"
			dropdownIcon.Rotation = 0
			dropdownIcon.Parent = dropdownButton

			local dropdownContent = Instance.new("Frame")
			dropdownContent.Size = UDim2.new(1, 0, 0, 0)
			dropdownContent.Position = UDim2.new(0, 0, 0, 40)
			dropdownContent.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			dropdownContent.BorderSizePixel = 0
			dropdownContent.ClipsDescendants = true
			dropdownContent.Visible = false
			dropdownContent.Parent = backdrop

			local contentPadding = Instance.new("UIPadding")
			contentPadding.PaddingBottom = UDim.new(0, 10)
			contentPadding.Parent = dropdownContent

			local contentCorner = Instance.new("UICorner")
			contentCorner.CornerRadius = UDim.new(0, 8)
			contentCorner.Parent = dropdownContent

			local dropdownLayout = Instance.new("UIListLayout")
			dropdownLayout.Parent = dropdownContent
			dropdownLayout.SortOrder = Enum.SortOrder.LayoutOrder
			dropdownLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			dropdownLayout.Padding = UDim.new(0, 5)

			local isOpen = false

			dropdownButton.MouseButton1Click:Connect(function()
				isOpen = not isOpen
				local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

				if isOpen then
					dropdownContent.Visible = true
					local targetHeight = dropdownLayout.AbsoluteContentSize.Y
					if targetHeight > 0 then
						targetHeight = targetHeight + 10
					end
					TweenService:Create(dropdownContent, tweenInfo, {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
					TweenService:Create(dropdownFrame, tweenInfo, {Size = UDim2.new(0.9, 0, 0, 40 + targetHeight)}):Play()
					TweenService:Create(dropdownIcon, tweenInfo, {Rotation = 180}):Play()
				else
					local contentTween = TweenService:Create(dropdownContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)})
					contentTween:Play()
					TweenService:Create(dropdownFrame, tweenInfo, {Size = UDim2.new(0.9, 0, 0, 40)}):Play()
					TweenService:Create(dropdownIcon, tweenInfo, {Rotation = 0}):Play()

					contentTween.Completed:Connect(function()
						dropdownContent.Visible = false
					end)
				end
			end)

			local dropdownMethods = createSectionMethods(dropdownContent)
			dropdownMethods.addSection = nil

			return dropdownMethods
		end

		return sectionMethods
	end

	function self.addSection(sectionName)
		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1, 0, 0, 40)
		button.BackgroundTransparency = 1
		button.Text = sectionName
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.Font = Enum.Font.GothamBold
		button.TextSize = 16
		button.Parent = sidebar

		local buttonCorner = Instance.new("UICorner")
		buttonCorner.CornerRadius = UDim.new(0, 2)
		buttonCorner.Parent = button

		local page = Instance.new("ScrollingFrame")
		page.Size = UDim2.new(1, 0, 1, 0)
		page.Position = UDim2.new(0, 0, 0, 0)
		page.BackgroundTransparency = 1
		page.Visible = false
		page.BorderSizePixel = 0
		page.ScrollBarThickness = 0
		page.ClipsDescendants = true
		page.CanvasSize = UDim2.new(0, 0, 0, 0)
		page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		page.Parent = contentFrame

		local pageCorner = Instance.new("UICorner")
		pageCorner.CornerRadius = UDim.new(0, 10)
		pageCorner.Parent = page

		local pageLayout = Instance.new("UIListLayout")
		pageLayout.Padding = UDim.new(0, 10)
		pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		pageLayout.Parent = page

		local pagePadding = Instance.new("UIPadding")
		pagePadding.PaddingTop = UDim.new(0, 15)
		pagePadding.Parent = page

		table.insert(sections, button)
		table.insert(pages, page)

		button.MouseButton1Click:Connect(function()
			for i, pg in ipairs(pages) do
				pg.Visible = false
			end
			page.Visible = true
			for _, btn in ipairs(sections) do
				btn.BackgroundTransparency = 1
			end
			button.BackgroundTransparency = 0
			button.BackgroundColor3 = Color3.fromHex(args.PrimaryColour)
		end)

		if #pages == 1 then
			page.Visible = true
			button.BackgroundTransparency = 0
			button.BackgroundColor3 = Color3.fromHex(args.PrimaryColour)
		end

		pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			page.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + pagePadding.PaddingTop.Offset + pagePadding.PaddingBottom.Offset)
		end)

		updateCanvasSize()

		return createSectionMethods(page)
	end

	return self
end

return Library