local a = game:GetService("TweenService")
local b = game:GetService("RunService")
local c = game:GetService("UserInputService")
local d = game:GetService("Players")
local e = d.LocalPlayer;
local f = e:GetMouse()
local g = game:GetService("HttpService")
local h = {
	Themes = {
		Legacy = {
			Main = Color3.fromHSV(262 / 360, 60 / 255, 34 / 255),
			Secondary = Color3.fromHSV(240 / 360, 40 / 255, 63 / 255),
			Tertiary = Color3.fromHSV(260 / 360, 60 / 255, 148 / 255),
			StrongText = Color3.fromHSV(0, 0, 1),
			WeakText = Color3.fromHSV(0, 0, 172 / 255)
		},
		Serika = {
			Main = Color3.fromRGB(50, 52, 55),
			Secondary = Color3.fromRGB(80, 82, 85),
			Tertiary = Color3.fromRGB(226, 183, 20),
			StrongText = Color3.fromHSV(0, 0, 1),
			WeakText = Color3.fromHSV(0, 0, 172 / 255)
		},
		Dark = {
			Main = Color3.fromRGB(30, 30, 35),
			Secondary = Color3.fromRGB(50, 50, 55),
			Tertiary = Color3.fromRGB(70, 130, 180),
			StrongText = Color3.fromHSV(0, 0, 1),
			WeakText = Color3.fromHSV(0, 0, 172 / 255)
		},
		Rust = {
			Main = Color3.fromRGB(37, 35, 33),
			Secondary = Color3.fromRGB(65, 63, 63),
			Tertiary = Color3.fromRGB(237, 94, 38),
			StrongText = Color3.fromHSV(0, 0, 1),
			WeakText = Color3.fromHSV(0, 0, 172 / 255)
		},
		Aqua = {
			Main = Color3.fromRGB(19, 21, 21),
			Secondary = Color3.fromRGB(65, 63, 63),
			Tertiary = Color3.fromRGB(51, 153, 137),
			StrongText = Color3.fromHSV(0, 0, 1),
			WeakText = Color3.fromHSV(0, 0, 172 / 255)
		},
		Vaporwave = {},
		OperaGX = {},
		VisualStudio = {}
	},
	ColorPickerStyles = {
		Legacy = 0,
		Modern = 1
	},
	Toggled = true,
	ThemeObjects = {
		Main = {},
		Secondary = {},
		Tertiary = {},
		StrongText = {},
		WeakText = {}
	},
	WelcomeText = nil,
	DisplayName = nil,
	DragSpeed = 0.06,
	LockDragging = false,
	ToggleKey = Enum.KeyCode.Home,
	UrlLabel = nil,
	Url = nil
}
h.__index = h;
local i;
h._promptExists = false;
h._colorPickerExists = false;
local j = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
function h:set_defaults(a, b)
	a = a or {}
	b = b or {}
	for b, c in next, b do
		a[b] = c
	end;
	return a
end;
function h:change_theme(a)
	h.CurrentTheme = a;
	local a = self:lighten(a.Tertiary, 20)
	h.DisplayName.Text = "Welcome, <font color='rgb(" .. math.floor(a.R * 255) .. "," .. math.floor(a.G * 255) .. "," .. math.floor(a.B * 255) .. ")'> <b>" .. e.DisplayName .. "</b> </font>"
	for a, b in next, h.ThemeObjects do
		local a = h.CurrentTheme[a]
		for a, a in next, b do
			local a, b, c, d = a[1], a[2], a[3], a[4] or 0;
			local c = h.CurrentTheme[c]
			local e = c;
			if d < 0 then
				e = h:darken(c, - 1 * d)
			elseif d > 0 then
				e = h:lighten(c, d)
			end;
			a:tween{
				[b] = e
			}
		end
	end
end;
function h:object(b, c)
	local b = Instance.new(b)
	local d = {
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Font = Enum.Font.SourceSans,
		Text = ""
	}
	for a, c in next, d do
		pcall(function()
			b[a] = c
		end)
	end;
	local d = {}
	d.AbsoluteObject = b;
	function d:tween(c, d)
		local c = h:set_defaults({
			Length = 0.2,
			Style = Enum.EasingStyle.Linear,
			Direction = Enum.EasingDirection.InOut
		}, c)
		d = d or function()
			return
		end;
		local e = TweenInfo.new(c.Length, c.Style, c.Direction)
		c.Length = nil;
		c.Style = nil;
		c.Direction = nil;
		local a = a:Create(b, e, c)
		a:Play()
		a.Completed:Connect(function()
			d()
		end)
		return a
	end;
	function d:round(a)
		a = a or 6;
		h:object("UICorner", {
			Parent = b,
			CornerRadius = UDim.new(0, a)
		})
		return d
	end;
	function d:object(a, c)
		local c = c or {}
		c.Parent = b;
		return h:object(a, c)
	end;
	function d:crossfade(a, b)
		b = b or .2;
		self:tween({
			ImageTransparency = 1
		})
		a:tween({
			ImageTransparency = 0
		})
	end;
	function d:fade(a, b, c, d)
		c = c or 0.2;
		if not rawget(self, "fadeFrame") then
			local a = self:object("Frame", {
				BackgroundColor3 = b or self.BackgroundColor3,
				BackgroundTransparency = (a and 1) or 0,
				Size = UDim2.fromScale(1, 1),
				Centered = true,
				ZIndex = 999
			}):round(self.AbsoluteObject:FindFirstChildOfClass("UICorner") and self.AbsoluteObject:FindFirstChildOfClass("UICorner").CornerRadius.Offset or 0)
			rawset(self, "fadeFrame", a)
		else
			self.fadeFrame.BackgroundColor3 = b or self.BackgroundColor3
		end;
		if d then
			if a then
				self.fadeFrame.BackgroundTransparency = 0;
				self.fadeFrame.Visible = true
			else
				self.fadeFrame.BackgroundTransparency = 1;
				self.fadeFrame.Visible = false
			end
		else
			if a then
				self.fadeFrame.BackgroundTransparency = 1;
				self.fadeFrame.Visible = true;
				self.fadeFrame:tween{
					BackgroundTransparency = 0,
					Length = c
				}
			else
				self.fadeFrame.BackgroundTransparency = 0;
				self.fadeFrame:tween({
					BackgroundTransparency = 1,
					Length = c
				}, function()
					self.fadeFrame.Visible = false
				end)
			end
		end
	end;
	function d:stroke(a, b, c)
		b = b or 1;
		c = c or Enum.ApplyStrokeMode.Border;
		local b = self:object("UIStroke", {
			ApplyStrokeMode = c,
			Thickness = b
		})
		if type(a) == "table" then
			local a, c = a[1], a[2] or 0;
			local d = h.CurrentTheme[a]
			local e = d;
			if c < 0 then
				e = h:darken(d, - 1 * c)
			elseif c > 0 then
				e = h:lighten(d, c)
			end;
			b.Color = e;
			table.insert(h.ThemeObjects[a], {
				b,
				"Color",
				a,
				c
			})
		elseif type(a) == "string" then
			local c = h.CurrentTheme[a]
			b.Color = c;
			table.insert(h.ThemeObjects[a], {
				b,
				"Color",
				a,
				0
			})
		else
			b.Color = a
		end;
		return d
	end;
	function d:tooltip(a)
		local a = d:object("TextLabel", {
			Theme = {
				BackgroundColor3 = {
					"Main",
					10
				},
				TextColor3 = {
					"WeakText"
				}
			},
			TextSize = 16,
			Text = a,
			Position = UDim2.new(0.5, 0, 0, - 8),
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			AnchorPoint = Vector2.new(0.5, 1),
			BackgroundTransparency = 1,
			TextTransparency = 1
		}):round(5)
		a.Size = UDim2.fromOffset(a.TextBounds.X + 16, a.TextBounds.Y + 8)
		local b = a:object("ImageLabel", {
			Image = "http://www.roblox.com/asset/?id=4292970642",
			Theme = {
				ImageColor3 = {
					"Main",
					10
				}
			},
			AnchorPoint = Vector2.new(0.5, 0),
			Rotation = 180,
			Position = UDim2.fromScale(0.5, 1),
			Size = UDim2.fromOffset(10, 6),
			BackgroundTransparency = 1,
			ImageTransparency = 1
		})
		local c = false;
		d.MouseEnter:connect(function()
			c = true;
			wait(0.2)
			if c then
				a:tween{
					BackgroundTransparency = 0.2,
					TextTransparency = 0.2
				}
				b:tween{
					ImageTransparency = 0.2
				}
			end
		end)
		d.MouseLeave:connect(function()
			c = false;
			a:tween{
				BackgroundTransparency = 1,
				TextTransparency = 1
			}
			b:tween{
				ImageTransparency = 1
			}
		end)
		return d
	end;
	local a = {
		Centered = function(a)
			if a then
				b.AnchorPoint = Vector2.new(0.5, 0.5)
				b.Position = UDim2.fromScale(0.5, 0.5)
			end
		end,
		Theme = function(a)
			for a, c in next, a do
				if type(c) == "table" then
					local c, e = c[1], c[2] or 0;
					local f = h.CurrentTheme[c]
					local g = f;
					if e < 0 then
						g = h:darken(f, - 1 * e)
					elseif e > 0 then
						g = h:lighten(f, e)
					end;
					b[a] = g;
					table.insert(self.ThemeObjects[c], {
						d,
						a,
						c,
						e
					})
				else
					local e = h.CurrentTheme[c]
					b[a] = e;
					table.insert(self.ThemeObjects[c], {
						d,
						a,
						c,
						0
					})
				end
			end
		end
	}
	for c, d in next, c do
		if a[c] then
			a[c](d)
		else
			b[c] = d
		end
	end;
	return setmetatable(d, {
		__index = function(a, a)
			return b[a]
		end,
		__newindex = function(a, a, c)
			b[a] = c
		end
	})
end;
function h:show(a)
	self.Toggled = a;
	self.mainFrame.ClipsDescendants = true;
	if a then
		self.mainFrame:tween({
			Size = self.mainFrame.oldSize,
			Length = 0.25
		}, function()
			rawset(self.mainFrame, "oldSize", (a and self.mainFrame.oldSize) or self.mainFrame.Size)
			self.mainFrame.ClipsDescendants = false
		end)
		wait(0.15)
		self.mainFrame:fade(not a, self.mainFrame.BackgroundColor3, 0.15)
	else
		self.mainFrame:fade(not a, self.mainFrame.BackgroundColor3, 0.15)
		wait(0.1)
		self.mainFrame:tween{
			Size = UDim2.new(),
			Length = 0.25
		}
	end
end;
function h:darken(a, b)
	local a, c, d = Color3.toHSV(a)
	b = 1 - ((b or 15) / 80)
	return Color3.fromHSV(a, math.clamp(c / b, 0, 1), math.clamp(d * b, 0, 1))
end;
function h:lighten(a, b)
	local a, c, d = Color3.toHSV(a)
	b = 1 - ((b or 15) / 80)
	return Color3.fromHSV(a, math.clamp(c * b, 0, 1), math.clamp(d / b, 0, 1))
end;
local a = function()
end;
function h:set_status(a)
	self.statusText.Text = a
end;
function h:create(j)
	local k = {
		Theme = "Dark"
	}
	if readfile and writefile and isfile then
		if not isfile("MercurySettings.json") then
			writefile("MercurySettings.json", g:JSONEncode(k))
		end;
		k = g:JSONDecode(readfile("MercurySettings.json"))
		h.CurrentTheme = h.Themes[k.Theme]
		a = function(a, b)
			k[a] = b;
			writefile("MercurySettings.json", g:JSONEncode(k))
		end
	end;
	j = self:set_defaults({
		Name = "MercuryUI",
		Size = UDim2.fromOffset(600, 400),
		Theme = self.Themes[k.Theme],
		Link = "https://www.youtube.com/dragondupe"
	}, j)
	if getgenv and getgenv().MercuryUI then
		getgenv():MercuryUI()
		getgenv().MercuryUI = nil
	end;
	if j.Link:sub(- 1, - 1) == "/" then
		j.Link = j.Link:sub(1, - 2)
	end;
	if j.Theme.Light then
		self.darken, self.lighten = self.lighten, self.darken
	end;
	self.CurrentTheme = j.Theme;
	local a = self:object("ScreenGui", {
		Parent = game:GetService("CoreGui"),
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		Name = "Dragon-Dupe"
	})
	local g = a:object("Frame", {
		AnchorPoint = Vector2.new(1, 1),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, - 30, 1, - 30),
		Size = UDim2.new(0, 300, 1, - 60)
	})
	local k = g:object("UIListLayout", {
		Padding = UDim.new(0, 20),
		VerticalAlignment = Enum.VerticalAlignment.Bottom
	})
	local k = a:object("Frame", {
		Size = UDim2.new(),
		Theme = {
			BackgroundColor3 = "Main"
		},
		Name = "__MAIN__",
		Centered = true,
		ClipsDescendants = true,
		Active = true,
		Draggable = true
	}):round(10)
	k:fade(true, nil, 0.2, true)
	k:fade(false, nil, 0.4)
	k:tween({
		Size = j.Size,
		Length = 0.3
	}, function()
		k.ClipsDescendants = false
	end)
	do
		local d, e = pcall(function()
			return k.MouseEnter
		end)
		if d then
			k.Active = true;
			e:connect(function()
				local a = k.InputBegan:connect(function(d)
					if d.UserInputType == Enum.UserInputType.MouseButton1 then
						local d = Vector2.new(f.X - k.AbsolutePosition.X, f.Y - k.AbsolutePosition.Y)
						while b.RenderStepped:wait() and c:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
							if h.LockDragging then
								local a, b = math.clamp(f.X - d.X, 0, a.AbsoluteSize.X - k.AbsoluteSize.X), math.clamp(f.Y - d.Y, 0, a.AbsoluteSize.Y - k.AbsoluteSize.Y)
								k:tween{
									Position = UDim2.fromOffset(a + (k.Size.X.Offset * k.AnchorPoint.X), b + (k.Size.Y.Offset * k.AnchorPoint.Y)),
									Length = h.DragSpeed
								}
							else
								k:tween{
									Position = UDim2.fromOffset(f.X - d.X + (k.Size.X.Offset * k.AnchorPoint.X), f.Y - d.Y + (k.Size.Y.Offset * k.AnchorPoint.Y)),
									Length = h.DragSpeed
								}
							end
						end
					end
				end)
				local b;
				b = k.MouseLeave:connect(function()
					a:disconnect()
					b:disconnect()
				end)
			end)
		end
	end;
	rawset(k, "oldSize", j.Size)
	self.mainFrame = k;
	local f = k:object("ScrollingFrame", {
		Size = UDim2.new(1, - 40, 0, 25),
		Position = UDim2.fromOffset(5, 5),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.X,
		AutomaticCanvasSize = Enum.AutomaticSize.X
	})
	f:object("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4)
	})
	local l = k:object("ImageButton", {
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(14, 14),
		Position = UDim2.new(1, - 11, 0, 11),
		Theme = {
			ImageColor3 = "StrongText"
		},
		Image = "http://www.roblox.com/asset/?id=8497487650",
		AnchorPoint = Vector2.new(1)
	})
	l.MouseEnter:connect(function()
		l:tween{
			ImageColor3 = Color3.fromRGB(255, 124, 142)
		}
	end)
	l.MouseLeave:connect(function()
		l:tween{
			ImageColor3 = h.CurrentTheme.StrongText
		}
	end)
	local function m()
		k.ClipsDescendants = true;
		k:fade(true)
		wait(0.1)
		k:tween({
			Size = UDim2.new()
		}, function()
			a.AbsoluteObject:Destroy()
		end)
	end;
	if getgenv then
		getgenv().MercuryUI = m
	end;
	l.MouseButton1Click:connect(function()
		m()
	end)
	local a = k:object("Frame", {
		Size = UDim2.new(1, - 10, 0, 25),
		Position = UDim2.new(0, 5, 0, 35),
		Theme = {
			BackgroundColor3 = "Secondary"
		}
	}):round(5)
	local l = a:object("ImageLabel", {
		AnchorPoint = Vector2.new(0, .5),
		Position = UDim2.new(0, 5, 0.5, 0);
		Theme = {
			ImageColor3 = "Tertiary"
		},
		Size = UDim2.fromOffset(16, 16),
		Image = "http://www.roblox.com/asset/?id=8497489946",
		BackgroundTransparency = 1
	})
	local a = a:object("TextLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 26, 0.5, 0),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, - 30, .6, 0),
		Text = j.Link .. "/home",
		Theme = {
			TextColor3 = "WeakText"
		},
		TextSize = 14,
		TextScaled = false,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	h.UrlLabel = a;
	h.Url = j.Link;
	local a = k:object("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0
	})
	local a = a:object("ImageLabel", {
		Centered = true,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 47, 1, 47),
		ZIndex = 0,
		Image = "rbxassetid://6015897843",
		ImageColor3 = Color3.new(0, 0, 0),
		ImageTransparency = .6,
		SliceCenter = Rect.new(47, 47, 450, 450),
		ScaleType = Enum.ScaleType.Slice,
		SliceScale = 1
	})
	local a = k:object("Frame", {
		Theme = {
			BackgroundColor3 = {
				"Secondary",
				- 10
			}
		},
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, - 20),
		Size = UDim2.new(1, - 10, 1, - 86)
	}):round(7)
	local l = k:object("TextLabel", {
		AnchorPoint = Vector2.new(0, 1),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 1, - 6),
		Size = UDim2.new(0.2, 0, 0, 10),
		Font = Enum.Font.SourceSans,
		Text = "Status | Idle",
		Theme = {
			TextColor3 = "Tertiary"
		},
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	local m = f:object("TextButton", {
		Name = "hehehe siuuuuuuuuu",
		BackgroundTransparency = 0,
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(0, 125, 0, 25)
	}):round(5)
	local n = m:object("TextLabel", {
		Theme = {
			TextColor3 = "StrongText"
		},
		AnchorPoint = Vector2.new(0, .5),
		BackgroundTransparency = 1,
		TextSize = 14,
		Text = j.Name,
		Position = UDim2.new(0, 25, 0.5, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, - 45, 0.5, 0),
		Font = Enum.Font.SourceSans,
		TextTruncate = Enum.TextTruncate.AtEnd
	})
	local n = m:object("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		Image = "http://www.roblox.com/asset/?id=8569322835",
		Theme = {
			ImageColor3 = "StrongText"
		}
	})
	local n = a:object("Frame", {
		Size = UDim2.fromScale(1, 1),
		Centered = true,
		BackgroundTransparency = 1
	})
	local o = {}
	i = m;
	o[# o + 1] = {
		n,
		m
	}
	do
		local a = false;
		local b = false;
		m.MouseEnter:connect(function()
			b = true;
			m:tween{
				BackgroundTransparency = ((i == m) and 0.15) or 0.3
			}
		end)
		m.MouseLeave:connect(function()
			b = false;
			m:tween{
				BackgroundTransparency = ((i == m) and 0.15) or 1
			}
		end)
		m.MouseButton1Down:connect(function()
			a = true;
			m:tween{
				BackgroundTransparency = 0
			}
		end)
		c.InputEnded:connect(function(c)
			if c.UserInputType == Enum.UserInputType.MouseButton1 then
				a = false;
				m:tween{
					BackgroundTransparency = ((i == m) and 0.15) or (b and 0.3) or 1
				}
			end
		end)
		m.MouseButton1Click:Connect(function()
			for a, a in next, o do
				local b = a[1]
				local a = a[2]
				b.Visible = false
			end;
			i:tween{
				BackgroundTransparency = ((i == m) and 0.15) or 1
			}
			i = m;
			n.Visible = true;
			m.BackgroundTransparency = 0;
			h.UrlLabel.Text = h.Url .. "/home"
		end)
	end;
	self.SelectedTabButton = m;
	local c = n:object("UIListLayout", {
		Padding = UDim.new(0, 10),
		FillDirection = Enum.FillDirection.Vertical,
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})
	local c = n:object("UIPadding", {
		PaddingTop = UDim.new(0, 10)
	})
	local c = n:object("Frame", {
		AnchorPoint = Vector2.new(0, .5),
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 100)
	}):round(7)
	local d = c:object("ImageLabel", {
		Image = d:GetUserThumbnailAsync(e.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100),
		Theme = {
			BackgroundColor3 = {
				"Secondary",
				10
			}
		},
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5),
		Size = UDim2.fromOffset(80, 80)
	}):round(100)
	local d;
	do
		local a, a, a = Color3.toHSV(j.Theme.Tertiary)
		local a = self:lighten(j.Theme.Tertiary, 20)
		local a = c:object("TextLabel", {
			RichText = true,
			Text = "Welcome, <font color='rgb(" .. math.floor(a.R * 255) .. "," .. math.floor(a.G * 255) .. "," .. math.floor(a.B * 255) .. ")'> <b>" .. e.DisplayName .. "</b> </font>",
			TextScaled = true,
			Position = UDim2.new(0, 105, 0, 10),
			Theme = {
				TextColor3 = {
					"Tertiary",
					10
				}
			},
			Size = UDim2.new(0, 400, 0, 40),
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left
		})
		h.DisplayName = a
	end;
	local d = c:object("TextLabel", {
		Text = "@" .. e.Name,
		TextScaled = true,
		Position = UDim2.new(0, 105, 0, 47),
		Theme = {
			TextColor3 = "Tertiary"
		},
		Size = UDim2.new(0, 400, 0, 20),
		BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left
	})
	local d = c:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 105, 1, - 10),
		Size = UDim2.new(0, 400, 0, 20),
		AnchorPoint = Vector2.new(0, 1),
		Theme = {
			TextColor3 = {
				"WeakText",
				- 20
			}
		},
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Text = tostring(os.date("%X")):sub(1, os.date("%X"):len() - 3)
	})
	do
		local a = 1;
		local c = 0;
		b.Heartbeat:Connect(function(b)
			c += b;
			if c >= a then
				c -= a;
				local a = tostring(os.date("%X"))
				d.Text = a:sub(1, a:len() - 3)
			end
		end)
	end;
	local b = c:object("ImageButton", {
		BackgroundTransparency = 1,
		Theme = {
			ImageColor3 = "WeakText"
		},
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, - 10, 1, - 10),
		AnchorPoint = Vector2.new(1, 1),
		Image = "http://www.roblox.com/asset/?id=8559790237"
	}):tooltip("settings")
	local c = c:object("ImageButton", {
		BackgroundTransparency = 1,
		Theme = {
			ImageColor3 = "WeakText"
		},
		Size = UDim2.fromOffset(24, 24),
		Position = UDim2.new(1, - 44, 1, - 10),
		AnchorPoint = Vector2.new(1, 1),
		Image = "http://www.roblox.com/asset/?id=8577523456"
	}):tooltip("credits")
	local d = n:object("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, - 20, 0, 180)
	})
	d:object("UIGridLayout", {
		CellPadding = UDim2.fromOffset(10, 10),
		CellSize = UDim2.fromOffset(55, 55),
		HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center
	})
	d:object("UIPadding", {
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 70),
		PaddingRight = UDim.new(0, 70),
		PaddingTop = UDim.new(0, 5)
	})
	local a = setmetatable({
		core = k,
		notifs = g,
		statusText = l,
		container = a,
		navigation = f,
		Theme = j.Theme,
		Tabs = o,
		quickAccess = d,
		homeButton = m,
		homePage = n,
		nilFolder = k:object("Folder")
	}, h)
	local b = h.tab(a, {
		Name = "Settings",
		Internal = b,
		Icon = "rbxassetid://8559790237"
	})
	b:_theme_selector()
	b:keybind{
		Name = "Toggle Key",
		Description = "Key to show/hide the UI.",
		Keybind = Enum.KeyCode.Delete,
		Callback = function()
			self.Toggled = not self.Toggled;
			h:show(self.Toggled)
		end
	}
	b:toggle{
		Name = "Lock Dragging",
		Description = "Makes sure you can't drag the UI outside of the window.",
		StartingState = true,
		Callback = function(a)
			h.LockDragging = a
		end
	}
	b:slider{
		Name = "UI Drag Speed",
		Description = "How smooth the dragging looks.",
		Max = 20,
		Default = 14,
		Callback = function(a)
			h.DragSpeed = (20 - a) / 100
		end
	}
	b:label{
		Name = "",
		Description = ""
	}
	local d, e = 550, 400;
	b:slider{
		Name = "UI Size X",
		Description = "Change UI Size.",
		Min = 100;
		Max = 900,
		Default = 550,
		Callback = function(a)
			d = a
		end
	}
	b:slider{
		Name = "UI Size Y",
		Description = "Change UI Size.",
		Min = 100;
		Max = 900,
		Default = 400,
		Callback = function(a)
			e = a
		end
	}
	b:button{
		Name = "Change UI Size!",
		Description = "Click Buttton To Change UI Size",
		Callback = function()
			game:GetService("CoreGui")["Dragon-Dupe"]["__MAIN__"].Size = UDim2.fromOffset(d, e)
		end
	}
	local b = h.tab(a, {
		Name = "Credits",
		Internal = c,
		Icon = "http://www.roblox.com/asset/?id=8577523456"
	})
	rawset(a, "creditsContainer", b.container)
    b:credit{
		Name = "Dragon Dupe",
		Description = "Owner Script",
		Discord = "Dragon Dupe#1089",
		YouTube = "https://www.youtube.com/dragondupe"
	}
    b:credit{
		Name = "Not JB37",
		Description = "Co-Owner Script",
		Discord = "not JB37#0296",
	}
    b:credit{
		Name = "Scorp Script",
		Description = "Scripting Help",
		Discord = "https://discord.gg/KKFfHrB5tb",
	}
	b:credit{
		Name = "Abstract",
		Description = "UI Library Developer",
		Discord = "Abstract#8007",
	}
	b:credit{
		Name = "Deity",
		Description = "UI Library Developer",
		Discord = "Deity#0228",
		YouTube = "https://www.youtube.com/@d4p4v"
	}

	return a
end;
function h:notification(a)
	a = self:set_defaults({
		Title = "Notification",
		Text = "Your character has been reset.",
		Duration = 3,
		Callback = function()
		end
	}, a)
	local b;
	local c = self.notifs:object("Frame", {
		BackgroundTransparency = 1,
		Theme = {
			BackgroundColor3 = "Main"
		},
		Size = UDim2.new(0, 300, 0, 0)
	}):round(10)
	local d = c:object("UIPadding", {
		PaddingBottom = UDim.new(0, 11),
		PaddingTop = UDim.new(0, 11),
		PaddingLeft = UDim.new(0, 11),
		PaddingRight = UDim.new(0, 11)
	})
	local d = c:object("Frame", {
		ZIndex = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	})
	local d = d:object("ImageLabel", {
		Centered = true,
		Position = UDim2.fromScale(.5, .5),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 70, 1, 70),
		ZIndex = 0,
		Image = "rbxassetid://6014261993",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 1,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450)
	})
	local e = c:object("Frame", {
		BackgroundTransparency = 1,
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 4)
	}):round(100)
	local f = e:object("Frame", {
		BackgroundTransparency = 1,
		Theme = {
			BackgroundColor3 = "Tertiary"
		},
		Size = UDim2.fromScale(1, 1)
	}):round(100)
	local g = c:object("ImageLabel", {
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Position = UDim2.fromOffset(1, 1),
		Size = UDim2.fromOffset(18, 18),
		Image = "rbxassetid://8628681683",
		Theme = {
			ImageColor3 = "Tertiary"
		}
	})
	local h = c:object("ImageButton", {
		Image = "http://www.roblox.com/asset/?id=8497487650",
		AnchorPoint = Vector2.new(1, 0),
		ImageColor3 = Color3.fromRGB(255, 255, 255),
		Position = UDim2.new(1, - 3, 0, 3),
		Size = UDim2.fromOffset(14, 14),
		BackgroundTransparency = 1,
		ImageTransparency = 1
	})
	h.MouseButton1Click:Connect(function()
		b()
	end)
	local i = c:object("TextLabel", {
		BackgroundTransparency = 1,
		Text = a.Text,
		Position = UDim2.new(0, 0, 0, 23),
		Size = UDim2.new(1, 0, 100, 0),
		TextSize = 16,
		TextTransparency = 1,
		TextWrapped = true,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextTransparency = 1
	})
	i:tween({
		Size = UDim2.new(1, 0, 0, i.TextBounds.Y)
	})
	local j = c:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(23, 0),
		Size = UDim2.new(1, - 60, 0, 20),
		Font = Enum.Font.SourceSansBold,
		Text = a.Title,
		Theme = {
			TextColor3 = "Tertiary"
		},
		TextSize = 17,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextTransparency = 1
	})
	b = function()
		task.delay(0.3, function()
			c.AbsoluteObject:Destroy()
			a.Callback()
		end)
		g:tween({
			ImageTransparency = 1,
			Length = 0.2
		})
		h:tween({
			ImageTransparency = 1,
			Length = 0.2
		})
		e:tween({
			BackgroundTransparency = 1,
			Length = 0.2
		})
		f:tween({
			BackgroundTransparency = 1,
			Length = 0.2
		})
		i:tween({
			TextTransparency = 1,
			Length = 0.2
		})
		j:tween({
			TextTransparency = 1,
			Length = 0.2
		}, function()
			d:tween({
				ImageTransparency = 1,
				Length = 0.2
			})
			c:tween({
				BackgroundTransparency = 1,
				Length = 0.2,
				Size = UDim2.fromOffset(300, 0)
			})
		end)
	end;
	d:tween({
		ImageTransparency = .6,
		Length = 0.2
	})
	c:tween({
		BackgroundTransparency = 0,
		Length = 0.2,
		Size = UDim2.fromOffset(300, i.TextBounds.Y + 63)
	}, function()
		g:tween({
			ImageTransparency = 0,
			Length = 0.2
		})
		h:tween({
			ImageTransparency = 0,
			Length = 0.2
		})
		e:tween({
			BackgroundTransparency = 0,
			Length = 0.2
		})
		f:tween({
			BackgroundTransparency = 0,
			Length = 0.2
		})
		i:tween({
			TextTransparency = 0,
			Length = 0.2
		})
		j:tween({
			TextTransparency = 0,
			Length = 0.2
		})
	end)
	f:tween({
		Size = UDim2.fromScale(0, 1),
		Length = a.Duration
	}, function()
		b()
	end)
end;
function h:tab(a)
	a = self:set_defaults({
		Name = "New Tab",
		Icon = "rbxassetid://8569322835"
	}, a)
	local b = self.container:object("ScrollingFrame", {
		AnchorPoint = Vector2.new(0, 1),
		Visible = false,
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.fromScale(1, 1),
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y
	})
	local d;
	local e;
	if not a.Internal then
		d = self.quickAccess:object("TextButton", {
			Theme = {
				BackgroundColor3 = "Secondary"
			}
		}):round(5):tooltip(a.Name)
		e = d:object("ImageLabel", {
			BackgroundTransparency = 1,
			Theme = {
				ImageColor3 = "StrongText"
			},
			Image = a.Icon,
			Size = UDim2.fromScale(0.5, 0.5),
			Centered = true
		})
	else
		d = a.Internal
	end;
	local e = b:object("UIListLayout", {
		Padding = UDim.new(0, 10),
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})
	b:object("UIPadding", {
		PaddingTop = UDim.new(0, 10)
	})
	local f = h:object("TextButton", {
		BackgroundTransparency = 1,
		Parent = self.nilFolder.AbsoluteObject,
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(0, 125, 0, 25),
		Visible = false
	}):round(5)
	self.Tabs[# self.Tabs + 1] = {
		b,
		f,
		a.Name
	}
	do
		local e = false;
		local g = false;
		f.MouseEnter:connect(function()
			g = true;
			f:tween{
				BackgroundTransparency = ((i == f) and 0.15) or 0.3
			}
		end)
		f.MouseLeave:connect(function()
			g = false;
			f:tween{
				BackgroundTransparency = ((i == f) and 0.15) or 1
			}
		end)
		f.MouseButton1Down:connect(function()
			e = true;
			f:tween{
				BackgroundTransparency = 0
			}
		end)
		c.InputEnded:connect(function(a)
			if a.UserInputType == Enum.UserInputType.MouseButton1 then
				e = false;
				f:tween{
					BackgroundTransparency = ((i == f) and 0.15) or (g and 0.3) or 1
				}
			end
		end)
		f.MouseButton1Click:Connect(function()
			for a, a in next, self.Tabs do
				local b = a[1]
				local a = a[2]
				b.Visible = false
			end;
			i:tween{
				BackgroundTransparency = ((i == f) and 0.15) or 1
			}
			i = f;
			b.Visible = true;
			f.BackgroundTransparency = 0;
			h.UrlLabel.Text = h.Url .. "/" .. a.Name:lower()
		end)
		d.MouseEnter:connect(function()
			d:tween{
				BackgroundColor3 = h.CurrentTheme.Tertiary
			}
		end)
		d.MouseLeave:connect(function()
			d:tween{
				BackgroundColor3 = h.CurrentTheme.Secondary
			}
		end)
		d.MouseButton1Click:connect(function()
			if not f.Visible then
				f.Parent = self.navigation.AbsoluteObject;
				f.Size = UDim2.new(0, 50, f.Size.Y.Scale, f.Size.Y.Offset)
				f.Visible = true;
				f:fade(false, h.CurrentTheme.Main, 0.1)
				f:tween({
					Size = UDim2.new(0, 125, f.Size.Y.Scale, f.Size.Y.Offset),
					Length = 0.1
				})
				for a, a in next, self.Tabs do
					local b = a[1]
					local a = a[2]
					b.Visible = false
				end;
				i:tween{
					BackgroundTransparency = ((i == f) and 0.15) or 1
				}
				i = f;
				b.Visible = true;
				f.BackgroundTransparency = 0;
				h.UrlLabel.Text = h.Url .. "/" .. a.Name:lower()
			end
		end)
	end;
	local c = f:object("TextLabel", {
		Theme = {
			TextColor3 = "StrongText"
		},
		AnchorPoint = Vector2.new(0, .5),
		BackgroundTransparency = 1,
		TextSize = 14,
		Text = a.Name,
		Position = UDim2.new(0, 25, 0.5, 0),
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, - 45, 0.5, 0),
		Font = Enum.Font.SourceSans,
		TextTruncate = Enum.TextTruncate.AtEnd
	})
	local a = f:object("ImageLabel", {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 0.5, 0),
		Size = UDim2.new(0, 15, 0, 15),
		Image = a.Icon,
		Theme = {
			ImageColor3 = "StrongText"
		}
	})
	local a = f:object("ImageButton", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, - 5, 0.5, 0),
		Size = UDim2.fromOffset(14, 14),
		Image = "rbxassetid://8497487650",
		Theme = {
			ImageColor3 = "StrongText"
		}
	})
	a.MouseButton1Click:connect(function()
		f:fade(true, h.CurrentTheme.Main, 0.1)
		f:tween({
			Size = UDim2.new(0, 50, f.Size.Y.Scale, f.Size.Y.Offset),
			Length = 0.1
		}, function()
			f.Visible = false;
			b.Visible = false;
			f.Parent = self.nilFolder.AbsoluteObject;
			wait()
		end)
		local a = {}
		for b, b in next, self.Tabs do
			if not b[2] == i then
				b[1].Visible = false
			end;
			if b[2].Visible then
				a[# a + 1] = b
			end
		end;
		local c = a[# a]
		if i == self.homeButton then
			b.Visible = false
		elseif # a == 2 then
			i.Visible = false;
			b.Visible = false;
			self.homePage.Visible = true;
			self.homeButton:tween{
				BackgroundTransparency = 0.15
			}
			i = self.homeButton;
			h.UrlLabel.Text = h.Url .. "/home"
		elseif f == c[2] then
			c = a[# a - 1]
			b.Visible = false;
			c[2]:tween{
				BackgroundTransparency = 0.15
			}
			c[1].Visible = true;
			i = c[2]
			h.UrlLabel.Text = h.Url .. "/" .. c[3]:lower()
		else
			b.Visible = false;
			c[2]:tween{
				BackgroundTransparency = 0.15
			}
			c[1].Visible = true;
			i = c[2]
			h.UrlLabel.Text = h.Url .. "/" .. c[3]:lower()
		end
	end)
	return setmetatable({
		statusText = self.statusText,
		container = b,
		Theme = self.Theme,
		core = self.core,
		layout = e
	}, h)
end;
function h:_resize_tab()
	if self.container.ClassName == "ScrollingFrame" then
		self.container.CanvasSize = UDim2.fromOffset(0, self.layout.AbsoluteContentSize.Y + 20)
	else
		self.sectionContainer.Size = UDim2.new(1, - 24, 0, self.layout.AbsoluteContentSize.Y + 20)
		self.parentContainer.CanvasSize = UDim2.fromOffset(0, self.parentLayout.AbsoluteContentSize.Y + 20)
	end
end;
function h:toggle(a)
	a = self:set_defaults({
		Name = "Toggle",
		StartingState = false,
		Description = nil,
		Callback = function(a)
		end
	}, a)
	local b = self.container:object("TextButton", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 52)
	}):round(7)
	local d = "http://www.roblox.com/asset/?id=8498709213"
	local e = "http://www.roblox.com/asset/?id=8498691125"
	local f = a.StartingState;
	local d = b:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, .5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, - 11, 0.5, 0),
		Size = UDim2.new(0, 26, 0, 26),
		Image = d,
		Theme = {
			ImageColor3 = "Tertiary"
		},
		ImageTransparency = (f and 0) or 1
	})
	local e = b:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, .5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, - 11, 0.5, 0),
		Size = UDim2.new(0, 26, 0, 26),
		Image = e,
		Theme = {
			ImageColor3 = "WeakText"
		},
		ImageTransparency = (f and 1) or 0
	})
	local g = b:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (a.Description and 5) or 0),
		Size = (a.Description and UDim2.new(0.5, - 10, 0, 22)) or UDim2.new(0.5, - 10, 1, 0),
		Text = a.Name,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	if a.Description then
		local a = b:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, - 10, 0, 20),
			Text = a.Description,
			TextSize = 18,
			Theme = {
				TextColor3 = "WeakText"
			},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end;
	local function g()
		f = not f;
		if f then
			e:crossfade(d, 0.1)
		else
			d:crossfade(e, 0.1)
		end;
		a.Callback(f)
	end;
	do
		local a = false;
		local d = false;
		b.MouseEnter:connect(function()
			a = true;
			b:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 10)
			}
		end)
		b.MouseLeave:connect(function()
			a = false;
			if not d then
				b:tween{
					BackgroundColor3 = h.CurrentTheme.Secondary
				}
			end
		end)
		b.MouseButton1Down:connect(function()
			b:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 20)
			}
		end)
		c.InputEnded:connect(function(c)
			if c.UserInputType == Enum.UserInputType.MouseButton1 then
				b:tween{
					BackgroundColor3 = (a and self:lighten(h.CurrentTheme.Secondary)) or h.CurrentTheme.Secondary
				}
			end
		end)
		b.MouseButton1Click:connect(function()
			g()
		end)
	end;
	self:_resize_tab()
	local b = {}
	function b:Toggle()
		g()
	end;
	function b:SetState(b)
		f = b;
		if f then
			e:crossfade(d, 0.1)
		else
			d:crossfade(e, 0.1)
		end;
		task.spawn(function()
			a.Callback(f)
		end)
	end;
	if a.StartingState then
		b:SetState(true)
	end;
	return b
end;
function h:dropdown(a)
	a = self:set_defaults({
		Name = "Dropdown",
		StartingText = "Select...",
		Items = {},
		Callback = function(a)
			return
		end
	}, a)
	local b = 0;
	local d = false;
	local e = self.container:object("TextButton", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 52)
	}):round(7)
	local f = e:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (a.Description and 5) or 15),
		Size = UDim2.new(0.5, - 10, 0, 22),
		Text = a.Name,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	if a.Description then
		local a = e:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, - 10, 0, 20),
			Text = a.Description,
			TextSize = 18,
			Theme = {
				TextColor3 = "WeakText"
			},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end;
	local f = e:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, - 11, 0, 12),
		Size = UDim2.fromOffset(26, 26),
		Image = "rbxassetid://8498840035",
		Theme = {
			ImageColor3 = "Tertiary"
		}
	})
	local g = e:object("TextLabel", {
		AnchorPoint = Vector2.new(1, 0),
		Theme = {
			BackgroundColor3 = {
				"Secondary",
				- 20
			},
			TextColor3 = "WeakText"
		},
		Position = UDim2.new(1, - 50, 0, 16),
		Size = UDim2.fromOffset(200, 20),
		TextSize = 14,
		Text = a.StartingText
	}):round(5):stroke("Tertiary")
	local i = e:object("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 0, 55),
		Size = UDim2.new(1, - 10, 0, 0),
		ClipsDescendants = true
	})
	g.Size = UDim2.fromOffset(g.TextBounds.X + 20, 20)
	local j = i:object("UIGridLayout", {
		CellPadding = UDim2.fromOffset(0, 5),
		CellSize = UDim2.new(1, 0, 0, 20),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Left,
		VerticalAlignment = Enum.VerticalAlignment.Top
	})
	local j = self.layout;
	local k = self.container;
	local l = setmetatable({}, {
		__newindex = function(a, c, d)
			rawset(a, c, d)
			if d ~= nil then
				b = (25 * # a) + 5;
				i.Size = UDim2.new(1, - 10, 0, b)
			end
		end
	})
	for a, b in next, a.Items do
		if typeof(b) == "table" then
			l[a] = b
		else
			l[a] = {
				tostring(b),
				b
			}
		end
	end;
	local m;
	for b, d in next, l do
		local e = d[1]
		local d = d[2]
		local f = i:object("TextButton", {
			Theme = {
				BackgroundColor3 = {
					"Secondary",
					25
				},
				TextColor3 = {
					"StrongText",
					25
				}
			},
			Text = e,
			TextSize = 14
		}):round(5)
		l[b] = {
			{
				e,
				d
			},
			f
		}
		do
			local b = false;
			local e = false;
			f.MouseEnter:connect(function()
				b = true;
				f:tween{
					BackgroundColor3 = h.CurrentTheme.Tertiary
				}
			end)
			f.MouseLeave:connect(function()
				b = false;
				if not e then
					f:tween{
						BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 25)
					}
				end
			end)
			f.MouseButton1Down:connect(function()
				f:tween{
					BackgroundColor3 = self:lighten(h.CurrentTheme.Tertiary, 10)
				}
			end)
			c.InputEnded:connect(function(a)
				if a.UserInputType == Enum.UserInputType.MouseButton1 then
					f:tween{
						BackgroundColor3 = (b and self:lighten(h.CurrentTheme.Tertiary, 5)) or self:lighten(h.CurrentTheme.Secondary, 25)
					}
				end
			end)
			f.MouseButton1Click:connect(function()
				m()
				g.Text = f.Text;
				g:tween{
					Size = UDim2.fromOffset(g.TextBounds.X + 20, 20),
					Length = 0.05
				}
				a.Callback(d)
			end)
		end
	end;
	do
		local a = false;
		local g = false;
		b = (25 * # l) + 5;
		i.Size = (not d and UDim2.new(1, - 10, 0, 0)) or UDim2.new(1, - 10, 0, b)
		m = function()
			b = (25 * # l) + 5;
			d = not d;
			if d then
				i:tween{
					Size = UDim2.new(1, - 10, 0, b)
				}
				e:tween({
					Size = UDim2.new(1, - 20, 0, 52 + b)
				}, function()
					self:_resize_tab()
				end)
				f:tween{
					Rotation = 180,
					Position = UDim2.new(1, - 11, 0, 15)
				}
			else
				i:tween{
					Size = UDim2.new(1, - 10, 0, 0)
				}
				e:tween({
					Size = UDim2.new(1, - 20, 0, 52)
				}, function()
					self:_resize_tab()
				end)
				f:tween{
					Rotation = 0,
					Position = UDim2.new(1, - 11, 0, 12)
				}
			end
		end;
		e.MouseEnter:connect(function()
			a = true;
			e:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 10)
			}
		end)
		e.MouseLeave:connect(function()
			a = false;
			if not g then
				e:tween{
					BackgroundColor3 = h.CurrentTheme.Secondary
				}
			end
		end)
		e.MouseButton1Down:connect(function()
			e:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 20)
			}
		end)
		c.InputEnded:connect(function(b)
			if b.UserInputType == Enum.UserInputType.MouseButton1 then
				e:tween{
					BackgroundColor3 = (a and self:lighten(h.CurrentTheme.Secondary)) or h.CurrentTheme.Secondary
				}
			end
		end)
		e.MouseButton1Click:connect(function()
			m()
		end)
	end;
	self:_resize_tab()
	local f = {}
	function f:Set(a)
		g.Text = a;
		g:tween{
			Size = UDim2.fromOffset(g.TextBounds.X + 20, 20),
			Length = 0.05
		}
	end;
	function f:RemoveItems(a)
		for a, a in next, a do
			for c, f in next, l do
				local g = f[1][1]
				if g:lower() == tostring(a):lower() then
					f[2].AbsoluteObject:Destroy()
					l[c] = nil;
					table.remove(l, c)
					b = (25 * # l) + 5;
					i:tween{
						Size = (not d and UDim2.new(1, - 10, 0, 0)) or UDim2.new(1, - 10, 0, b)
					}
					e:tween({
						Size = (not d and UDim2.new(1, - 20, 0, 52)) or UDim2.new(1, - 20, 0, 52 + b)
					})
				end
			end
		end
	end;
	function f:Clear()
		table.clear(l)
		i:tween{
			Size = UDim2.new(1, - 10, 0, 0)
		}
		e:tween({
			Size = UDim2.new(1, - 20, 0, 52)
		}, function()
			for a, a in next, i.AbsoluteObject:GetChildren() do
				if a.ClassName == "TextButton" then
					a:Destroy()
				end
			end
		end)
		if d then
			m()
		end
	end;
	function f:AddItems(f)
		for a, a in next, f do
			if typeof(a) == "table" then
				l[# l + 1] = a
			else
				l[# l + 1] = {
					tostring(a),
					a
				}
			end
		end;
		b = (25 * # l) + 5;
		i:tween{
			Size = (not d and UDim2.new(1, - 10, 0, 0)) or UDim2.new(1, - 10, 0, b)
		}
		e:tween({
			Size = (not d and UDim2.new(1, - 20, 0, 52)) or UDim2.new(1, - 20, 0, 52 + b)
		})
		for b, d in next, l do
			local e = d[1]
			local d = d[2]
			if type(e) == "table" then
				continue
			end;
			local f = i:object("TextButton", {
				Theme = {
					BackgroundColor3 = {
						"Secondary",
						25
					},
					TextColor3 = {
						"StrongText",
						25
					}
				},
				Text = e,
				TextSize = 14
			}):round(5)
			l[b] = {
				{
					e,
					d
				},
				f
			}
			do
				local b = false;
				local e = false;
				f.MouseEnter:connect(function()
					b = true;
					f:tween{
						BackgroundColor3 = h.CurrentTheme.Tertiary
					}
				end)
				f.MouseLeave:connect(function()
					b = false;
					if not e then
						f:tween{
							BackgroundColor3 = h:lighten(h.CurrentTheme.Secondary, 25)
						}
					end
				end)
				f.MouseButton1Down:connect(function()
					f:tween{
						BackgroundColor3 = h:lighten(h.CurrentTheme.Tertiary, 10)
					}
				end)
				c.InputEnded:connect(function(a)
					if a.UserInputType == Enum.UserInputType.MouseButton1 then
						f:tween{
							BackgroundColor3 = (b and h:lighten(h.CurrentTheme.Tertiary, 5)) or h:lighten(h.CurrentTheme.Secondary, 25)
						}
					end
				end)
				f.MouseButton1Click:connect(function()
					m()
					g.Text = f.Text;
					g:tween{
						Size = UDim2.fromOffset(g.TextBounds.X + 20, 20),
						Length = 0.05
					}
					a.Callback(d)
				end)
			end
		end;
		h._resize_tab({
			container = k,
			layout = j
		})
	end;
	return f
end;
function h:section(a)
	a = self:set_defaults({
		Name = "Section"
	}, a)
	local b = self.container:object("TextButton", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, - 24, 0, 52)
	}):round(7):stroke("Secondary", 2)
	local a = b:object("TextLabel", {
		Position = UDim2.new(0.5),
		Text = a.Name,
		TextSize = 18,
		Theme = {
			TextColor3 = "StrongText",
			BackgroundColor3 = {
				"Secondary",
				- 10
			}
		},
		TextXAlignment = Enum.TextXAlignment.Center,
		AnchorPoint = Vector2.new(0.5, 0.5)
	})
	a.Size = UDim2.fromOffset(a.TextBounds.X + 4, a.TextBounds.Y)
	local a = b:object("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1
	})
	local c = a:object("UIListLayout", {
		Padding = UDim.new(0, 10),
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})
	a:object("UIPadding", {
		PaddingTop = UDim.new(0, 10)
	})
	return setmetatable({
		statusText = self.statusText,
		container = a,
		sectionContainer = b,
		parentContainer = self.container,
		Theme = self.Theme,
		core = self.core,
		parentLayout = self.layout,
		layout = c
	}, h)
end;
function h:button(a)
	a = self:set_defaults({
		Name = "Button",
		Description = nil,
		Callback = function()
		end
	}, a)
	local b = self.container:object("TextButton", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 52)
	}):round(7)
	local d = b:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (a.Description and 5) or 0),
		Size = (a.Description and UDim2.new(0.5, - 10, 0, 22)) or UDim2.new(0.5, - 10, 1, 0),
		Text = a.Name,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	if a.Description then
		local a = b:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, - 10, 0, 20),
			Text = a.Description,
			TextSize = 18,
			Theme = {
				TextColor3 = "WeakText"
			},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end;
	local e = b:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, - 11, 0.5, 0),
		Size = UDim2.fromOffset(26, 26),
		Image = "rbxassetid://8498776661",
		Theme = {
			ImageColor3 = "Tertiary"
		}
	})
	do
		local d = false;
		local e = false;
		b.MouseEnter:connect(function()
			d = true;
			b:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 10)
			}
		end)
		b.MouseLeave:connect(function()
			d = false;
			if not e then
				b:tween{
					BackgroundColor3 = h.CurrentTheme.Secondary
				}
			end
		end)
		b.MouseButton1Down:connect(function()
			b:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 20)
			}
		end)
		c.InputEnded:connect(function(a)
			if a.UserInputType == Enum.UserInputType.MouseButton1 then
				b:tween{
					BackgroundColor3 = (d and self:lighten(h.CurrentTheme.Secondary)) or h.CurrentTheme.Secondary
				}
			end
		end)
		b.MouseButton1Click:connect(function()
			a.Callback()
		end)
	end;
	self:_resize_tab()
	local b = {}
	function b:Fire()
		a.Callback()
	end;
	function b:SetText(a)
		d.Text = a
	end;
	return b
end;
function h:color_picker(a)
	a = self:set_defaults({
		Name = "Color Picker",
		Description = nil,
		Style = h.ColorPickerStyles.Legacy,
		Followup = false,
		Callback = function(a)
		end
	}, a)
	local d = self.container:object("TextButton", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 52)
	}):round(7)
	local e = d:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (a.Description and 5) or 0),
		Size = (a.Description and UDim2.new(0.5, - 10, 0, 22)) or UDim2.new(0.5, - 10, 1, 0),
		Text = a.Name,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	if a.Description then
		local a = d:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, - 10, 0, 20),
			Text = a.Description,
			TextSize = 18,
			Theme = {
				TextColor3 = "WeakText"
			},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end;
	local e = d:object("ImageLabel", {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, - 11, 0.5, 0),
		Size = UDim2.fromOffset(26, 26),
		Image = "rbxassetid://8604555937",
		ImageColor3 = h.CurrentTheme.Tertiary
	})
	do
		local g = false;
		local i = false;
		d.MouseEnter:connect(function()
			g = true;
			d:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 10)
			}
		end)
		d.MouseLeave:connect(function()
			g = false;
			if not i then
				d:tween{
					BackgroundColor3 = h.CurrentTheme.Secondary
				}
			end
		end)
		d.MouseButton1Down:connect(function()
			d:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 20)
			}
		end)
		c.InputEnded:connect(function(a)
			if a.UserInputType == Enum.UserInputType.MouseButton1 then
				d:tween{
					BackgroundColor3 = (g and self:lighten(h.CurrentTheme.Secondary)) or h.CurrentTheme.Secondary
				}
			end
		end)
		d.MouseButton1Click:connect(function()
			if h._colorPickerExists then
				return
			end;
			h._colorPickerExists = true;
			local d, g, i;
			local j, k;
			local l;
			local m = Color3.fromRGB(255, 0, 0)
			local n = self.core:object("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2
			}):round(10)
			if a.Style == 1 then
				do
					local o = n:object("ImageLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 365, 0, 102),
						Size = UDim2.new(0, 56, 0, 48),
						ZIndex = 10,
						Image = "rbxassetid://8579148508",
						ImageColor3 = m,
						ImageTransparency = 1,
						Rotation = 180
					})
					local p = n:object("ImageLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 364, 0, 158),
						Rotation = - 4,
						Size = UDim2.new(0, 141, 0, 37),
						ZIndex = 10,
						Image = "rbxassetid://8579166120",
						ImageColor3 = m,
						ImageTransparency = 0
					})
					local q = n:object("Frame", {
						AnchorPoint = Vector2.new(.5, .5),
						BackgroundTransparency = 1,
						Position = UDim2.new(0.5, - 50, 0.5, 0),
						Size = UDim2.fromOffset(160, 240),
						ZIndex = 12
					})
					local r = q:object("Frame", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						ZIndex = 11
					})
					local r = r:object("ImageLabel", {
						Centered = true,
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 47, 1, 47),
						ZIndex = 11,
						Image = "rbxassetid://6015897843",
						ImageColor3 = Color3.new(0, 0, 0),
						ImageTransparency = 1,
						SliceCenter = Rect.new(49, 49, 450, 450),
						ScaleType = Enum.ScaleType.Slice,
						SliceScale = 1
					})
					local s = q:object("Frame", {
						AnchorPoint = Vector2.new(1, 1),
						BackgroundColor3 = Color3.new(0, 0, 0),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 1),
						Size = UDim2.new(1, - 5, 0, 50),
						ZIndex = 12
					})
					local t = s:object("TextButton", {
						Centered = true,
						BackgroundTransparency = 1,
						TextTransparency = 1,
						Size = UDim2.fromOffset(80, 20),
						ZIndex = 12,
						Text = "SELECT",
						TextSize = 13,
						Theme = {
							TextColor3 = {
								"Tertiary",
								- 10
							},
							BackgroundColor3 = {
								"Tertiary",
								- 10
							}
						}
					}):round(8):stroke({
						"Tertiary",
						- 10
					})
					do
						local b = false;
						local d = false;
						t.MouseEnter:connect(function()
							b = true;
							t:tween{
								BackgroundTransparency = 0,
								TextColor3 = self:lighten(h.CurrentTheme.StrongText, 15)
							}
						end)
						t.MouseLeave:connect(function()
							b = false;
							if not d then
								t:tween{
									BackgroundTransparency = 1,
									TextColor3 = self:darken(h.CurrentTheme.Tertiary, 10)
								}
							end
						end)
						t.MouseButton1Down:connect(function()
							t:tween{
								BackgroundColor3 = self:lighten(h.CurrentTheme.Tertiary, 20)
							}
						end)
						c.InputEnded:connect(function(a)
							if a.UserInputType == Enum.UserInputType.MouseButton1 then
								t:tween{
									BackgroundTransparency = (b and 0) or 1
								}
								if b then
									t:tween{
										BackgroundColor3 = h.CurrentTheme.Tertiary
									}
								end
							end
						end)
						t.MouseButton1Click:connect(function()
							l()
							e:tween({
								ImageColor3 = m
							})
							a.Callback(m)
							task.delay(0.35, function()
								h._colorPickerExists = false
							end)
						end)
					end;
					local a = q:object("TextButton", {
						BackgroundColor3 = Color3.new(255, 255, 255),
						BorderSizePixel = 0,
						Text = "",
						Size = UDim2.new(0, 5, 1, 0),
						ZIndex = 12,
						ClipsDescendants = true,
						BackgroundTransparency = 1
					})
					local e = a:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
							ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
							ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
							ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
							ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
							ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
						},
						Rotation = 90
					})
					local e = a:object("ImageButton", {
						BackgroundTransparency = 1,
						ImageTransparency = 1,
						Position = UDim2.new(- 2, 3, 0, - 10),
						Size = UDim2.fromOffset(20, 20),
						ZIndex = 12,
						Image = "rbxassetid://8579244616"
					})
					local h = q:object("TextButton", {
						Text = "",
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 0),
						Size = UDim2.new(1, - 5, 1, - 50),
						ZIndex = 12,
						ClipsDescendants = true
					})
					local q = h:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 13,
						BackgroundColor3 = m,
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					})
					local u = h:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 14,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					})
					local v = u:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
						},
						Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1)
						}
					})
					local v = h:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 16,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					})
					local w = v:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
						},
						Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1)
						},
						Rotation = - 90
					})
					local w = h:object("TextButton", {
						Text = "",
						AnchorPoint = Vector2.new(.5, .5),
						BackgroundTransparency = 1,
						Size = UDim2.fromOffset(6, 6),
						Position = UDim2.new(0, 152, 0, 3),
						ZIndex = 20
					}):round(100)
					local x = w:object("UIStroke", {
						Color = Color3.fromRGB(255, 255, 255),
						Thickness = 1.6,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
						Transparency = 1
					})
					do
						k = function()
							d = math.clamp((f.Y - a.AbsolutePosition.Y) / (a.AbsoluteSize.Y), 0, 1)
							local b = math.clamp((f.Y - h.AbsolutePosition.Y) / (h.AbsoluteSize.Y), 0, 1)
							local c = math.clamp((f.Y - a.AbsolutePosition.Y) / (a.AbsoluteSize.Y) * a.AbsoluteSize.Y, 0, a.AbsoluteSize.Y)
							m = Color3.fromHSV(d, g, i)
							q:tween({
								Length = 0.05,
								BackgroundColor3 = Color3.fromHSV(d, 1, 1)
							})
							p:tween({
								ImageColor3 = m,
								Length = 0.05
							})
							o:tween({
								ImageColor3 = m,
								Length = 0.05
							})
							e:tween({
								Length = 0.05,
								Position = UDim2.new(- 2, 3, 0, math.clamp(c - 10, - 10, a.AbsoluteSize.Y + 10)),
								ImageColor3 = Color3.fromHSV(1, 0, - b)
							})
						end;
						local d = false;
						a.MouseButton1Down:Connect(function()
							d = true;
							while b.RenderStepped:Wait() and d do
								k()
							end
						end)
						e.MouseButton1Down:connect(function()
							d = true;
							while b.RenderStepped:Wait() and d do
								k()
							end
						end)
						c.InputEnded:Connect(function(a)
							if a.UserInputType == Enum.UserInputType.MouseButton1 then
								if d then
									d = false
								end
							end
						end)
					end;
					do
						local a = false;
						j = function()
							g = math.clamp((f.X - h.AbsolutePosition.X) / (h.AbsoluteSize.X), 0, 1)
							i = 1 - math.clamp((f.Y - h.AbsolutePosition.Y) / (h.AbsoluteSize.Y), 0, 1)
							local a = math.clamp((f.X - h.AbsolutePosition.X) / (h.AbsoluteSize.X) * h.AbsoluteSize.X, 0, h.AbsoluteSize.X)
							local b = math.clamp((f.Y - h.AbsolutePosition.Y) / (h.AbsoluteSize.Y) * h.AbsoluteSize.Y, 0, h.AbsoluteSize.Y)
							m = Color3.fromHSV(d, g, i)
							w:tween({
								Position = UDim2.fromOffset(a, b),
								Length = 0.05
							})
							p:tween({
								ImageColor3 = m,
								Length = 0.05
							})
							o:tween({
								ImageColor3 = m,
								Length = 0.05
							})
						end;
						h.MouseButton1Down:Connect(function()
							a = true;
							while b.RenderStepped:wait() and a do
								j()
							end
						end)
						c.InputEnded:Connect(function(b)
							if b.UserInputType == Enum.UserInputType.MouseButton1 then
								if a then
									a = false
								end
							end
						end)
					end;
					n:tween({
						BackgroundTransparency = .4,
						Length = 0.1
					})
					o:tween({
						ImageTransparency = 0,
						Length = 0.1
					})
					p:tween({
						ImageTransparency = 0,
						Length = 0.1
					})
					r:tween({
						ImageTransparency = .6,
						Length = 0.1
					})
					s:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					t:tween({
						TextTransparency = 0,
						Length = 0.1
					})
					a:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					e:tween({
						ImageTransparency = 0,
						Length = 0.1
					})
					q:tween{
						BackgroundTransparency = 0,
						Length = 0.1
					}
					u:tween{
						BackgroundTransparency = 0,
						Length = 0.1
					}
					v:tween{
						BackgroundTransparency = 0,
						Length = 0.1
					}
					x:tween{
						Transparency = 0,
						Length = 0.1
					}
					l = function()
						n:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						o:tween({
							ImageTransparency = 1,
							Length = 0.1
						})
						p:tween({
							ImageTransparency = 1,
							Length = 0.1
						})
						r:tween({
							ImageTransparency = 1,
							Length = 0.1
						})
						s:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						t:tween({
							TextTransparency = 1,
							Length = 0.1
						})
						a:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						e:tween({
							ImageTransparency = 1,
							Length = 0.1
						})
						q:tween{
							BackgroundTransparency = 1,
							Length = 0.1
						}
						u:tween{
							BackgroundTransparency = 1,
							Length = 0.1
						}
						v:tween{
							BackgroundTransparency = 1,
							Length = 0.1
						}
						x:tween({
							Transparency = 1,
							Length = 0.1
						}, function()
							task.delay(0.25, function()
								n.AbsoluteObject:Destroy()
							end)
						end)
					end
				end
			else
				do
					local o = n:object("Frame", {
						Centered = true,
						Theme = {
							BackgroundColor3 = "Secondary"
						},
						BackgroundTransparency = 1,
						Size = UDim2.fromOffset(255, 170)
					}):round(6)
					local p = o:object("UIStroke", {
						Transparency = 1,
						Theme = {
							Color = "Tertiary"
						},
						Thickness = 1.6
					})
					local q = o:object("UIPadding", {
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
						PaddingTop = UDim.new(0, 5),
						PaddingBottom = UDim.new(0, 5)
					})
					local q = o:object("TextButton", {
						Text = "",
						BackgroundTransparency = 1,
						Size = UDim2.new(0.5, - 5, 1, - 25)
					}):round(6)
					local r = q:object("UIStroke", {
						Transparency = 1,
						Theme = {
							Color = "Tertiary"
						},
						Thickness = 1.6
					})
					local s = q:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						BackgroundColor3 = m,
						BackgroundTransparency = 1,
						ZIndex = 10
					}):round(6)
					local t = q:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 11,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						BorderSizePixel = 0
					}):round(6)
					local u = t:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
						},
						Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1)
						}
					})
					local u = q:object("Frame", {
						Size = UDim2.fromScale(1, 1),
						ZIndex = 12,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					}):round(6)
					local v = u:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
						},
						Transparency = NumberSequence.new{
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1)
						},
						Rotation = - 90
					})
					local v = q:object("TextButton", {
						Centered = true,
						Text = "",
						AnchorPoint = Vector2.new(.5, .5),
						BackgroundTransparency = 1,
						Size = UDim2.fromOffset(6, 6),
						ZIndex = 20
					}):round(100)
					local w = v:object("UIStroke", {
						Transparency = 1,
						Color = Color3.fromRGB(255, 255, 255),
						Thickness = 1.6,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					})
					local x = o:object("TextButton", {
						Text = "",
						AnchorPoint = Vector2.new(0, 1),
						Position = UDim2.fromScale(0, 1),
						Size = UDim2.new(0.5, - 5, 0, 20),
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						BackgroundTransparency = 1,
						ZIndex = 11
					}):round(6)
					local y = x:object("UIStroke", {
						Transparency = 1,
						Theme = {
							Color = "Tertiary"
						},
						Thickness = 1.6
					})
					local z = x:object("UIGradient", {
						Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
							ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
							ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
							ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
							ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
							ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
						}
					})
					local z = x:object("TextButton", {
						Centered = true,
						Text = "",
						BackgroundTransparency = 1,
						Size = UDim2.new(0, 3, 1, 0),
						ZIndex = 20
					})
					local A = z:object("UIStroke", {
						Transparency = 1,
						Color = Color3.fromRGB(255, 255, 255),
						Thickness = 1.6,
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					})
					local B = o:object("TextLabel", {
						Text = "Color Picker",
						Font = Enum.Font.SourceSansBold,
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1,
						Position = UDim2.fromScale(1, 0),
						Size = UDim2.new(0.5, 0, 0, 20),
						Theme = {
							TextColor3 = {
								"Tertiary",
								15
							}
						},
						TextSize = 15,
						TextTransparency = 1
					})
					local C = o:object("Frame", {
						AnchorPoint = Vector2.new(1, 0),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, 0, 0, 25),
						Size = UDim2.new(0.5, 0, 0, 60)
					})
					local D = C:object("UIListLayout", {
						Padding = UDim.new(0, 4),
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.Name
					})
					local D = C:object("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0),
						Name = "1",
						Text = tostring(m.R * 255),
						Theme = {
							BackgroundColor3 = {
								"Secondary",
								12
							}
						},
						Size = UDim2.new(1, - 10, 0, 18),
						TextColor3 = Color3.fromHSV(0, 0.8, 1),
						TextSize = 14,
						BackgroundTransparency = 1,
						TextTransparency = 1
					}):round(4)
					local E = C:object("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0),
						Name = "2",
						Text = tostring(m.G * 255),
						Theme = {
							BackgroundColor3 = {
								"Secondary",
								12
							}
						},
						Size = UDim2.new(1, - 10, 0, 18),
						TextColor3 = Color3.fromHSV(120 / 360, 0.8, 1),
						TextSize = 14,
						BackgroundTransparency = 1,
						TextTransparency = 1
					}):round(4)
					local C = C:object("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0),
						Text = tostring(m.B * 255),
						Name = "3",
						Theme = {
							BackgroundColor3 = {
								"Secondary",
								12
							}
						},
						Size = UDim2.new(1, - 10, 0, 18),
						TextColor3 = Color3.fromHSV(240 / 360, 0.8, 1),
						TextSize = 14,
						BackgroundTransparency = 1,
						TextTransparency = 1
					}):round(4)
					local F = o:object("ImageButton", {
						AnchorPoint = Vector2.new(1, 1),
						Theme = {
							BackgroundColor3 = "Tertiary"
						},
						Position = UDim2.fromScale(1, 1),
						Size = UDim2.new(0.5, 0, 0, 20),
						Image = "rbxassetid://8593962406",
						ScaleType = Enum.ScaleType.Fit,
						BackgroundTransparency = 1,
						ImageTransparency = 1
					}):round(6)
					local G = o:object("Frame", {
						AnchorPoint = Vector2.new(1, 1),
						BackgroundColor3 = m,
						Position = UDim2.new(1, - 65, 1, - 25),
						Size = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1
					}):round(5)
					local H = G:object("ImageLabel", {
						Centered = true,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(.6, .6),
						Image = "rbxassetid://8593995344",
						ImageColor3 = Color3.fromRGB(255, 255, 255),
						ImageTransparency = 1
					})
					local I = o:object("Frame", {
						AnchorPoint = Vector2.new(1, 1),
						BackgroundColor3 = m,
						Position = UDim2.new(1, - 15, 1, - 25),
						Size = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1
					}):round(5)
					local J = I:object("ImageLabel", {
						Centered = true,
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(.6, .6),
						Image = "rbxassetid://8593995344",
						ImageColor3 = Color3.fromRGB(0, 0, 0),
						ImageTransparency = 1
					})
					for a, a in next, n.AbsoluteObject:GetDescendants() do
						pcall(function()
							a.ZIndex += 3
						end)
					end;
					local function K()
						D.Text = tostring(math.floor(m.R * 255))
						E.Text = tostring(math.floor(m.G * 255))
						C.Text = tostring(math.floor(m.B * 255))
						I:tween({
							BackgroundColor3 = m
						})
						G:tween({
							BackgroundColor3 = m
						})
					end;
					do
						k = function()
							d = math.clamp((f.X - x.AbsolutePosition.X) / (x.AbsoluteSize.X), 0, 1)
							local a = math.clamp((f.X - x.AbsolutePosition.X) / (x.AbsoluteSize.X) * x.AbsoluteSize.X, 0, x.AbsoluteSize.X)
							m = Color3.fromHSV(d, g, i)
							s:tween({
								Length = 0.05,
								BackgroundColor3 = Color3.fromHSV(d, 1, 1)
							})
							z:tween({
								Length = 0.05,
								Position = UDim2.new(0, math.clamp(a, 0, x.AbsoluteSize.X), .5, 0)
							})
							K()
						end;
						local a = false;
						x.MouseButton1Down:Connect(function()
							a = true;
							while b.RenderStepped:Wait() and a do
								k()
							end
						end)
						z.MouseButton1Down:connect(function()
							a = true;
							while b.RenderStepped:Wait() and a do
								k()
							end
						end)
						c.InputEnded:Connect(function(b)
							if b.UserInputType == Enum.UserInputType.MouseButton1 then
								if a then
									a = false
								end
							end
						end)
					end;
					do
						local a = false;
						j = function()
							g = math.clamp((f.X - q.AbsolutePosition.X) / (q.AbsoluteSize.X), 0, 1)
							i = 1 - math.clamp((f.Y - q.AbsolutePosition.Y) / (q.AbsoluteSize.Y), 0, 1)
							local a = math.clamp((f.X - q.AbsolutePosition.X) / (q.AbsoluteSize.X) * q.AbsoluteSize.X, 0, q.AbsoluteSize.X)
							local b = math.clamp((f.Y - q.AbsolutePosition.Y) / (q.AbsoluteSize.Y) * q.AbsoluteSize.Y, 0, q.AbsoluteSize.Y)
							m = Color3.fromHSV(d, g, i)
							K()
							v:tween({
								Position = UDim2.fromOffset(a, b),
								Length = 0.05
							})
						end;
						q.MouseButton1Down:Connect(function()
							a = true;
							while b.RenderStepped:wait() and a do
								j()
							end
						end)
						c.InputEnded:Connect(function(b)
							if b.UserInputType == Enum.UserInputType.MouseButton1 then
								if a then
									a = false
								end
							end
						end)
					end;
					do
						local b = false;
						local d = false;
						F.MouseEnter:connect(function()
							d = true;
							F:tween{
								BackgroundColor3 = self:lighten(h.CurrentTheme.Tertiary, 10)
							}
						end)
						F.MouseLeave:connect(function()
							d = false;
							if not b then
								F:tween{
									BackgroundColor3 = h.CurrentTheme.Tertiary
								}
							end
						end)
						F.MouseButton1Down:connect(function()
							F:tween{
								BackgroundColor3 = self:lighten(h.CurrentTheme.Tertiary, 20)
							}
						end)
						c.InputEnded:connect(function(a)
							if a.UserInputType == Enum.UserInputType.MouseButton1 then
								F:tween{
									BackgroundColor3 = (d and self:lighten(h.CurrentTheme.Tertiary)) or h.CurrentTheme.Tertiary
								}
							end
						end)
						F.MouseButton1Click:connect(function()
							l()
							e:tween({
								ImageColor3 = m
							})
							a.Callback(m)
							task.delay(0.35, function()
								h._colorPickerExists = false
							end)
						end)
					end;
					o:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					p:tween({
						Transparency = 0,
						Length = 0.1
					})
					q:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					r:tween({
						Transparency = 0,
						Length = 0.1
					})
					s:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					t:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					u:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					w:tween({
						Transparency = 0,
						Length = 0.1
					})
					x:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					y:tween({
						Transparency = 0,
						Length = 0.1
					})
					A:tween({
						Transparency = 0,
						Length = 0.1
					})
					B:tween{
						TextTransparency = 0,
						Length = 0.1
					}
					D:tween({
						BackgroundTransparency = 0,
						TextTransparency = 0,
						Length = 0.1
					})
					E:tween({
						BackgroundTransparency = 0,
						TextTransparency = 0,
						Length = 0.1
					})
					C:tween({
						BackgroundTransparency = 0,
						TextTransparency = 0,
						Length = 0.1
					})
					F:tween({
						BackgroundTransparency = 0,
						ImageTransparency = 0,
						Length = 0.1
					})
					G:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					H:tween({
						ImageTransparency = 0,
						Length = 0.1
					})
					I:tween({
						BackgroundTransparency = 0,
						Length = 0.1
					})
					J:tween({
						ImageTransparency = 0,
						Length = 0.1
					})
					n:tween({
						BackgroundTransparency = 0.5,
						Length = 0.1
					})
					l = function()
						o:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						p:tween({
							Transparency = 1,
							Length = 0.1
						})
						q:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						r:tween({
							Transparency = 1,
							Length = 0.1
						})
						s:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						t:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						u:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						w:tween({
							Transparency = 1,
							Length = 0.1
						})
						x:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						y:tween({
							Transparency = 1,
							Length = 0.1
						})
						A:tween({
							Transparency = 1,
							Length = 0.1
						})
						B:tween{
							TextTransparency = 1,
							Length = 0.1
						}
						D:tween({
							BackgroundTransparency = 1,
							TextTransparency = 1,
							Length = 0.1
						})
						E:tween({
							BackgroundTransparency = 1,
							TextTransparency = 1,
							Length = 0.1
						})
						C:tween({
							BackgroundTransparency = 1,
							TextTransparency = 1,
							Length = 0.1
						})
						F:tween({
							BackgroundTransparency = 1,
							ImageTransparency = 1,
							Length = 0.1
						})
						G:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						H:tween({
							ImageTransparency = 1,
							Length = 0.1
						})
						I:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						})
						J:tween({
							ImageTransparency = 1,
							Length = 0.1
						})
						n:tween({
							BackgroundTransparency = 1,
							Length = 0.1
						}, function()
							task.delay(0.25, function()
								n.AbsoluteObject:Destroy()
							end)
						end)
					end
				end
			end
		end)
	end;
	self:_resize_tab()
end;
function h:credit(a)
	a = self:set_defaults({
		Name = "Creditor",
		Description = nil
	}, a)
	a.YouTube = a.YouTube or a.youtube;
	local b = (self.creditsContainer or self.container):object("Frame", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 52)
	}):round(7)
	local c = b:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (a.Description and 5) or 0),
		Size = (a.Description and UDim2.new(0.5, - 10, 0, 22)) or UDim2.new(0.5, - 10, 1, 0),
		Text = a.Name,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	if a.Description then
		local a = b:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, - 10, 0, 20),
			Text = a.Description,
			TextSize = 18,
			Theme = {
				TextColor3 = "WeakText"
			},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end;
	if setclipboard then
		if a.Discord then
			local b = b:object("TextButton", {
				AnchorPoint = Vector2.new(1, 1),
				Size = UDim2.fromOffset(24, 24),
				Position = UDim2.new(1, - 8, 1, - 8),
				BackgroundColor3 = Color3.fromRGB(88, 101, 242)
			}):round(5):tooltip("copy discord")
			local c = b:object("Frame", {
				Size = UDim2.new(1, - 6, 1, - 6),
				Centered = true,
				BackgroundTransparency = 1
			})
			local d = c:object("ImageLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 0),
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(1, 0, 0, - 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = "http://www.roblox.com/asset/?id=8594150191",
				ScaleType = Enum.ScaleType.Crop
			})
			local d = c:object("ImageLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0, 0),
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(0, 0, 0, - 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = "http://www.roblox.com/asset/?id=8594187532",
				ScaleType = Enum.ScaleType.Crop
			})
			local d = c:object("ImageLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0, 1),
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(0, 0, 1, 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = "http://www.roblox.com/asset/?id=8594194954",
				ScaleType = Enum.ScaleType.Crop
			})
			local c = c:object("ImageLabel", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 1),
				Size = UDim2.new(0.5, 0, 0.5, 0),
				Position = UDim2.new(1, 0, 1, 0),
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				Image = "http://www.roblox.com/asset/?id=8594206483",
				ScaleType = Enum.ScaleType.Crop
			})
			b.MouseButton1Click:connect(function()
				setclipboard(a.Discord)
			end)
		end;
		if a.YouTube then
			local b = b:object("TextButton", {
				AnchorPoint = Vector2.new(1, 1),
				Size = UDim2.fromOffset(24, 24),
				Position = UDim2.new(1, - 40, 1, - 8),
				Theme = {
					BackgroundColor3 = {
						"Main",
						10
					}
				}
			}):round(5):tooltip("copy youtube")
			local c = b:object("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=8594086769",
				Size = UDim2.new(1, - 4, 1, - 4),
				Centered = true,
				BackgroundTransparency = 1
			})
			b.MouseButton1Click:connect(function()
				setclipboard(a.YouTube)
			end)
		end
	end;
	self._resize_tab({
		container = self.creditsContainer or self.container,
		layout = (self.creditsContainer and self.creditsContainer.AbsoluteObject.UIListLayout) or self.layout
	})
end;
function h:_theme_selector()
	local b = 0;
	for a in next, h.Themes do
		b += 1
	end;
	local b = self.container:object("Frame", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 127)
	}):round(7)
	local c = b:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 5),
		Size = UDim2.new(0.5, - 10, 0, 22),
		Text = "Theme",
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	local b = b:object("Frame", {
		Size = UDim2.new(1, 0, 1, - 32),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 1, - 5),
		AnchorPoint = Vector2.new(0.5, 1)
	})
	local c = b:object("UIGridLayout", {
		CellPadding = UDim2.fromOffset(10, 10),
		CellSize = UDim2.fromOffset(102, 83),
		VerticalAlignment = Enum.VerticalAlignment.Center
	})
	b:object("UIPadding", {
		PaddingLeft = UDim.new(0, 10),
		PaddingTop = UDim.new(0, 5)
	})
	for c, d in next, h.Themes do
		local e = 0;
		for a, a in next, d do
			if not (type(a) == "boolean") then
				e += 1
			end
		end;
		if e >= 5 then
			local b = b:object("TextButton", {
				BackgroundTransparency = 1
			})
			local e = b:object("Frame", {
				Size = UDim2.new(1, 0, 1, - 20),
				BackgroundTransparency = 1
			}):round(5):stroke("WeakText", 1)
			local f = b:object("TextLabel", {
				BackgroundTransparency = 1,
				Text = c,
				TextSize = 16,
				Theme = {
					TextColor3 = "StrongText"
				},
				Size = UDim2.new(1, 0, 0, 20),
				Position = UDim2.fromScale(0, 1),
				AnchorPoint = Vector2.new(0, 1)
			})
			local e = e:object("Frame", {
				Centered = true,
				Size = UDim2.fromScale(1, 1),
				BackgroundColor3 = d.Main
			}):round(4)
			local e = e:object("Frame", {
				Centered = true,
				Size = UDim2.new(1, - 16, 1, - 16),
				BackgroundColor3 = d.Secondary
			}):round(4)
			e:object("UIListLayout", {
				Padding = UDim.new(0, 5)
			})
			e:object("UIPadding", {
				PaddingTop = UDim.new(0, 5),
				PaddingLeft = UDim.new(0, 5)
			})
			local f = e:object("Frame", {
				Size = UDim2.new(1, - 20, 0, 9),
				BackgroundColor3 = d.Tertiary
			}):round(100)
			local f = e:object("Frame", {
				Size = UDim2.new(1, - 30, 0, 9),
				BackgroundColor3 = d.StrongText
			}):round(100)
			local d = e:object("Frame", {
				Size = UDim2.new(1, - 40, 0, 9),
				BackgroundColor3 = d.WeakText
			}):round(100)
			b.MouseButton1Click:connect(function()
				h:change_theme(h.Themes[c])
				a("Theme", c)
			end)
		end
	end;
	self:_resize_tab()
end;
function h:keybind(a)
	a = self:set_defaults({
		Name = "Keybind",
		Keybind = nil,
		Description = nil,
		Callback = function()
		end
	}, a)
	local b = self.container:object("TextButton", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 52)
	}):round(7)
	local d = b:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (a.Description and 5) or 0),
		Size = (a.Description and UDim2.new(0.5, - 10, 0, 22)) or UDim2.new(0.5, - 10, 1, 0),
		Text = a.Name,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	if a.Description then
		local a = b:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, - 10, 0, 20),
			Text = a.Description,
			TextSize = 18,
			Theme = {
				TextColor3 = "WeakText"
			},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end;
	local d = b:object("TextLabel", {
		AnchorPoint = Vector2.new(1, 0),
		Theme = {
			BackgroundColor3 = {
				"Secondary",
				- 20
			},
			TextColor3 = "WeakText"
		},
		Position = UDim2.new(1, - 20, 0, 16),
		Size = UDim2.new(0, 50, 0, 20),
		TextSize = 12,
		Text = (a.Keybind and tostring(a.Keybind.Name):upper()) or "?"
	}):round(5):stroke("Tertiary")
	d.Size = UDim2.fromOffset(d.TextBounds.X + 20, 20)
	do
		local e = false;
		local f = false;
		local g = false;
		b.MouseEnter:connect(function()
			e = true;
			b:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 10)
			}
		end)
		b.MouseLeave:connect(function()
			e = false;
			if not f then
				b:tween{
					BackgroundColor3 = h.CurrentTheme.Secondary
				}
			end
		end)
		b.MouseButton1Down:connect(function()
			b:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 20)
			}
		end)
		c.InputEnded:connect(function(a)
			if a.UserInputType == Enum.UserInputType.MouseButton1 then
				b:tween{
					BackgroundColor3 = (e and self:lighten(h.CurrentTheme.Secondary)) or h.CurrentTheme.Secondary
				}
			end
		end)
		c.InputBegan:Connect(function(b, e)
			if g and not c:GetFocusedTextBox() then
				if b.UserInputType == Enum.UserInputType.Keyboard then
					if b.KeyCode ~= Enum.KeyCode.Escape then
						a.Keybind = b.KeyCode
					end;
					d.Text = (a.Keybind and tostring(a.Keybind.Name):upper()) or "?"
					d:tween{
						Size = UDim2.fromOffset(d.TextBounds.X + 20, 20),
						Length = 0.05
					}
					g = false
				end
			else
				if b.KeyCode == a.Keybind then
					a.Callback()
				end
			end
		end)
		b.MouseButton1Click:connect(function()
			if not g then
				g = true;
				d.Text = "..."
			end
		end)
	end;
	self:_resize_tab()
	local b = {}
	function b:Set(b)
		a.Keybind = b;
		d.Text = (a.Keybind and tostring(a.Keybind.Name):upper()) or "?"
		d:tween{
			Size = UDim2.fromOffset(d.TextBounds.X + 20, 20),
			Length = 0.05
		}
	end;
	return b
end;
function h:prompt(a)
	a = self:set_defaults({
		Followup = false,
		Title = "Prompt",
		Text = "yo momma dead",
		Buttons = {
			ok = function()
				return true
			end
		}
	}, a)
	if h._promptExists and not a.Followup then
		return
	end;
	h._promptExists = true;
	local b = 0;
	for a, a in next, a.Buttons do
		b += 1
	end;
	local d = self.core:object("Frame", {
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1)
	}):round(10)
	local e = d:object("Frame", {
		Theme = {
			BackgroundColor3 = "Main"
		},
		BackgroundTransparency = 1,
		Centered = true,
		Size = UDim2.fromOffset(200, 120)
	}):round(6)
	local f = e:object("UIStroke", {
		Theme = {
			Color = "Tertiary"
		},
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Transparency = 1
	})
	local g = e:object("UIPadding", {
		PaddingTop = UDim.new(0, 5),
		PaddingLeft = UDim.new(0, 5),
		PaddingBottom = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5)
	})
	local g = e:object("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 20),
		TextXAlignment = Enum.TextXAlignment.Center,
		Font = Enum.Font.SourceSansBold,
		Text = a.Title,
		Theme = {
			TextColor3 = {
				"Tertiary",
				15
			}
		},
		TextSize = 16,
		TextTransparency = 1
	})
	local i = e:object("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0, 26),
		Size = UDim2.new(1, - 20, 1, - 60),
		TextSize = 14,
		Theme = {
			TextColor3 = "StrongText"
		},
		Text = a.Text,
		TextTransparency = 1,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextXAlignment = Enum.TextXAlignment.Center,
		TextWrapped = true,
		TextTruncate = Enum.TextTruncate.AtEnd
	})
	local j = e:object("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 0, 1, - 5),
		Size = UDim2.new(1, 0, 0, 20)
	})
	local b = j:object("UIGridLayout", {
		CellPadding = UDim2.new(0, 10, 0, 5),
		CellSize = UDim2.new(1 / b, - 10, 1, 0),
		FillDirection = Enum.FillDirection.Horizontal,
		HorizontalAlignment = Enum.HorizontalAlignment.Center
	})
	d:tween({
		BackgroundTransparency = 0.4,
		Length = 0.1
	})
	e:tween({
		BackgroundTransparency = 0,
		Length = 0.1
	})
	g:tween({
		TextTransparency = 0,
		Length = 0.1
	})
	f:tween({
		Transparency = 0,
		Length = 0.1
	})
	i:tween({
		TextTransparency = 0,
		Length = 0.1
	})
	local b = {}
	for a, k in next, a.Buttons do
		local a = j:object("TextButton", {
			AnchorPoint = Vector2.new(1, 1),
			Theme = {
				BackgroundColor3 = "Tertiary"
			},
			Text = tostring(a):upper(),
			TextSize = 13,
			Font = Enum.Font.SourceSansBold,
			BackgroundTransparency = 1,
			TextTransparency = 1
		}):round(4)
		table.insert(b, a)
		do
			a:tween({
				TextTransparency = 0,
				BackgroundTransparency = 0
			})
			local j = false;
			local l = false;
			a.MouseEnter:connect(function()
				j = true;
				a:tween{
					BackgroundColor3 = self:lighten(h.CurrentTheme.Tertiary, 10)
				}
			end)
			a.MouseLeave:connect(function()
				j = false;
				if not l then
					a:tween{
						BackgroundColor3 = h.CurrentTheme.Tertiary
					}
				end
			end)
			a.MouseButton1Down:connect(function()
				a:tween{
					BackgroundColor3 = self:lighten(h.CurrentTheme.Tertiary, 20)
				}
			end)
			c.InputEnded:connect(function(b)
				if b.UserInputType == Enum.UserInputType.MouseButton1 then
					a:tween{
						BackgroundColor3 = (j and self:lighten(h.CurrentTheme.Tertiary)) or h.CurrentTheme.Tertiary
					}
				end
			end)
			a.MouseButton1Click:connect(function()
				e:tween({
					BackgroundTransparency = 1,
					Length = 0.1
				})
				g:tween({
					TextTransparency = 1,
					Length = 0.1
				})
				f:tween({
					Transparency = 1,
					Length = 0.1
				})
				i:tween({
					TextTransparency = 1,
					Length = 0.1
				})
				for a, a in next, b do
					a:tween({
						TextTransparency = 1,
						BackgroundTransparency = 1,
						Length = 0.1
					})
				end;
				d:tween({
					BackgroundTransparency = 1,
					Length = 0.1
				}, function()
					d.AbsoluteObject:Destroy()
					task.delay(0.25, function()
						h._promptExists = false
					end)
					k()
				end)
			end)
		end
	end
end;
function h:cp(a)
	return h.color_picker(self, a)
end;
function h:colorpicker(a)
	return h.color_picker(self, a)
end;
function h:slider(a)
	a = self:set_defaults({
		Name = "Slider",
		Default = 50,
		Min = 0,
		Max = 100,
		Callback = function()
		end
	}, a)
	local d = self.container:object("TextButton", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 56)
	}):round(7)
	local e = d:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 5),
		Size = UDim2.new(0.5, - 10, 0, 22),
		Text = a.Name,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	if a.Description then
		local a = d:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, - 10, 0, 20),
			Text = a.Description,
			TextSize = 18,
			Theme = {
				TextColor3 = "WeakText"
			},
			TextXAlignment = Enum.TextXAlignment.Left
		})
		d.Size = UDim2.new(1, - 20, 0, 76)
	end;
	local e = d:object("TextLabel", {
		AnchorPoint = Vector2.new(1, 0),
		Theme = {
			BackgroundColor3 = {
				"Secondary",
				- 20
			},
			TextColor3 = "WeakText"
		},
		Position = UDim2.new(1, - 10, 0, 10),
		Size = UDim2.new(0, 50, 0, 20),
		TextSize = 12,
		Text = a.Default
	}):round(5):stroke("Tertiary")
	e.Size = UDim2.fromOffset(e.TextBounds.X + 20, 20)
	local g = d:object("Frame", {
		Theme = {
			BackgroundColor3 = {
				"Secondary",
				- 20
			}
		},
		AnchorPoint = Vector2.new(0.5, 1),
		Size = UDim2.new(1, - 20, 0, 5),
		Position = UDim2.new(0.5, 0, 1, - 12)
	}):round(100)
	local i = g:object("Frame", {
		Size = UDim2.fromScale(((a.Default - a.Min) / (a.Max - a.Min)), 1),
		Theme = {
			BackgroundColor3 = "Tertiary"
		}
	}):round(100)
	local j = i:object("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(1, 0.5),
		Size = UDim2.fromOffset(14, 14),
		Theme = {
			BackgroundColor3 = {
				"Tertiary",
				20
			}
		}
	}):round(100)
	do
		local j = false;
		local k = false;
		d.MouseEnter:connect(function()
			j = true;
			d:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 10)
			}
		end)
		d.MouseLeave:connect(function()
			j = false;
			if not k then
				d:tween{
					BackgroundColor3 = h.CurrentTheme.Secondary
				}
			end
		end)
		c.InputEnded:connect(function(a)
			if a.UserInputType == Enum.UserInputType.MouseButton1 or a.UserInputType == Enum.UserInputType.Touch then
				k = false;
				d:tween{
					BackgroundColor3 = (j and self:lighten(h.CurrentTheme.Secondary)) or h.CurrentTheme.Secondary
				}
			end
		end)
		g.InputBegan:Connect(function()
			d:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 20)
			}
			k = true;
			local c = e:tween{
				Size = UDim2.fromOffset(e.TextBounds.X + 20, 20)
			}
			while b.RenderStepped:wait() and k do
				local b = math.clamp((f.X - g.AbsolutePosition.X) / (g.AbsoluteSize.X), 0, 1)
				local d = ((a.Max - a.Min) * b) + a.Min;
				d = math.floor(d)
				e.Text = d;
				if c.PlaybackState == Enum.PlaybackState.Completed then
					c = e:tween{
						Size = UDim2.fromOffset(e.TextBounds.X + 20, 20)
					}
				end;
				i:tween{
					Length = 0.06,
					Size = UDim2.fromScale(b, 1)
				}
				a.Callback(d)
			end
		end)
	end;
	self:_resize_tab()
	local b = {}
	function b:Set(b)
		i:tween{
			Size = UDim2.fromScale(((b - a.Min) / (a.Max - a.Min)), 1)
		}
	end;
	return b
end;
function h:textbox(a)
	a = self:set_defaults({
		Name = "Text Box",
		Placeholder = "Type something..",
		Description = nil,
		Callback = function(a)
		end
	}, a)
	local c = self.container:object("TextButton", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 52)
	}):round(7)
	local d = c:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, (a.Description and 5) or 0),
		Size = (a.Description and UDim2.new(0.5, - 10, 0, 22)) or UDim2.new(0.5, - 10, 1, 0),
		Text = a.Name,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	if a.Description then
		local a = c:object("TextLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 27),
			Size = UDim2.new(0.5, - 10, 0, 20),
			Text = a.Description,
			TextSize = 18,
			Theme = {
				TextColor3 = "WeakText"
			},
			TextXAlignment = Enum.TextXAlignment.Left
		})
	end;
	local d = c:object("TextBox", {
		AnchorPoint = Vector2.new(1, 0),
		Theme = {
			BackgroundColor3 = {
				"Secondary",
				- 20
			},
			TextColor3 = "WeakText"
		},
		Position = UDim2.new(1, - 50, 0, 16),
		Size = UDim2.new(0, 50, 0, 20),
		TextSize = 12,
		PlaceholderText = a.Placeholder,
		ClipsDescendants = true
	}):round(5):stroke("Tertiary")
	local e = c:object("ImageLabel", {
		Image = "http://www.roblox.com/asset/?id=8569329416",
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, - 13, 0.5, 0),
		Size = UDim2.new(0, 16, 0, 16),
		Theme = {
			ImageColor3 = "StrongText"
		}
	})
	d.Size = UDim2.fromOffset(d.TextBounds.X + 20, 20)
	do
		local e = false;
		local f = false;
		local g = false;
		c.MouseEnter:connect(function()
			c:tween{
				BackgroundColor3 = self:lighten(h.CurrentTheme.Secondary, 10)
			}
		end)
		c.MouseLeave:connect(function()
			e = false;
			if not f then
				c:tween{
					BackgroundColor3 = h.CurrentTheme.Secondary
				}
			end
		end)
		d.Focused:connect(function()
			g = true;
			while g and b.RenderStepped:wait() do
				d.AbsoluteObject:TweenSize(UDim2.fromOffset(math.clamp(d.TextBounds.X + 20, 0, 0.5 * c.AbsoluteSize.X), 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0.1, true)
			end
		end)
		d.FocusLost:connect(function()
			g = false;
			d.AbsoluteObject:TweenSize(UDim2.fromOffset(math.clamp(d.TextBounds.X + 20, 0, 0.5 * c.AbsoluteSize.X), 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0.1, true)
			a.Callback(d.Text)
		end)
	end;
	self:_resize_tab()
	local a = {}
	function a:Set(a)
		d.Text = a
	end;
	return a
end;
function h:label(a)
	a = self:set_defaults({
		Text = "Label title",
		Description = "Label text"
	}, a)
	local b = self.container:object("TextButton", {
		Theme = {
			BackgroundColor3 = "Secondary"
		},
		Size = UDim2.new(1, - 20, 0, 52),
		BackgroundTransparency = 1
	}):round(7):stroke("Secondary", 2)
	local c = b:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, 5),
		Size = UDim2.new(0.5, - 10, 0, 22),
		Text = a.Text,
		TextSize = 22,
		Theme = {
			TextColor3 = "StrongText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	local a = b:object("TextLabel", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 1, - 5),
		Size = UDim2.new(0.5, - 10, 1, - 22),
		Text = a.Description,
		TextSize = 18,
		AnchorPoint = Vector2.new(0, 1),
		Theme = {
			TextColor3 = "WeakText"
		},
		TextXAlignment = Enum.TextXAlignment.Left
	})
	self:_resize_tab()
	local b = {}
	function b:SetText(a)
		c.Text = a
	end;
	function b:SetDescription(b)
		a.Text = b
	end;
	return b
end;
return setmetatable(h, {
	__index = function(a, a)
		return rawget(h, a:lower())
	end
})