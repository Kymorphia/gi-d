module Gsk.Types;

import GLib.ErrorG;
import Gid.gid;
import Graphene.Point;
import Gsk.c.functions;
import Gsk.c.types;


// Enums
alias BlendMode = GskBlendMode;
alias Corner = GskCorner;
alias FillRule = GskFillRule;
alias GLUniformType = GskGLUniformType;
alias LineCap = GskLineCap;
alias LineJoin = GskLineJoin;
alias MaskMode = GskMaskMode;
alias PathDirection = GskPathDirection;
alias PathForeachFlags = GskPathForeachFlags;
alias PathOperation = GskPathOperation;
alias RenderNodeType = GskRenderNodeType;
alias ScalingFilter = GskScalingFilter;
alias SerializationError = GskSerializationError;
alias TransformCategory = GskTransformCategory;

// Structs
alias BroadwayRendererClass = GskBroadwayRendererClass*;
alias CairoRendererClass = GskCairoRendererClass*;
alias GLRendererClass = GskGLRendererClass*;
alias ParseLocation = GskParseLocation;
alias RendererClass = GskRendererClass*;
alias VulkanRendererClass = GskVulkanRendererClass*;

// Callbacks
alias ParseErrorFunc = void delegate(ParseLocation start, ParseLocation end, ErrorG error);
alias PathForeachFunc = bool delegate(PathOperation op, Point pts, size_t nPts, float weight);
