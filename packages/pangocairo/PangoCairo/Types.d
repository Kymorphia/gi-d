module PangoCairo.Types;

import Gid.gid;
import Pango.AttrShape;
import PangoCairo.c.functions;
import PangoCairo.c.types;
import cairo.Context;


// Callbacks
alias ShapeRendererFunc = void delegate(Context cr, AttrShape attr, bool doPath);
