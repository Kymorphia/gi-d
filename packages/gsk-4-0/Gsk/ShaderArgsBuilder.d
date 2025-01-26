module Gsk.ShaderArgsBuilder;

import GLib.Boxed;
import Gid.gid;
import Graphene.Vec2;
import Graphene.Vec3;
import Graphene.Vec4;
import Gsk.Types;
import Gsk.c.functions;
import Gsk.c.types;

/**
 * An object to build the uniforms data for a `GskGLShader`.
 */
class ShaderArgsBuilder : Boxed
{

  this(void* ptr, bool ownedRef = false)
  {
    super(cast(void*)ptr, ownedRef);
  }

  void* cPtr(bool makeCopy = false)
  {
    return makeCopy ? copy_ : cInstancePtr;
  }

  static GType getType()
  {
    return gsk_shader_args_builder_get_type();
  }

  override @property GType gType()
  {
    return getType();
  }

  /**
   * Sets the value of the uniform idx.
   * The uniform must be of bool type.
   * Params:
   *   idx = index of the uniform
   *   value = value to set the uniform to
   */
  void setBool(int idx, bool value)
  {
    gsk_shader_args_builder_set_bool(cast(GskShaderArgsBuilder*)cPtr, idx, value);
  }

  /**
   * Sets the value of the uniform idx.
   * The uniform must be of float type.
   * Params:
   *   idx = index of the uniform
   *   value = value to set the uniform to
   */
  void setFloat(int idx, float value)
  {
    gsk_shader_args_builder_set_float(cast(GskShaderArgsBuilder*)cPtr, idx, value);
  }

  /**
   * Sets the value of the uniform idx.
   * The uniform must be of int type.
   * Params:
   *   idx = index of the uniform
   *   value = value to set the uniform to
   */
  void setInt(int idx, int value)
  {
    gsk_shader_args_builder_set_int(cast(GskShaderArgsBuilder*)cPtr, idx, value);
  }

  /**
   * Sets the value of the uniform idx.
   * The uniform must be of uint type.
   * Params:
   *   idx = index of the uniform
   *   value = value to set the uniform to
   */
  void setUint(int idx, uint value)
  {
    gsk_shader_args_builder_set_uint(cast(GskShaderArgsBuilder*)cPtr, idx, value);
  }

  /**
   * Sets the value of the uniform idx.
   * The uniform must be of vec2 type.
   * Params:
   *   idx = index of the uniform
   *   value = value to set the uniform too
   */
  void setVec2(int idx, Vec2 value)
  {
    gsk_shader_args_builder_set_vec2(cast(GskShaderArgsBuilder*)cPtr, idx, value ? cast(graphene_vec2_t*)value.cPtr(false) : null);
  }

  /**
   * Sets the value of the uniform idx.
   * The uniform must be of vec3 type.
   * Params:
   *   idx = index of the uniform
   *   value = value to set the uniform too
   */
  void setVec3(int idx, Vec3 value)
  {
    gsk_shader_args_builder_set_vec3(cast(GskShaderArgsBuilder*)cPtr, idx, value ? cast(graphene_vec3_t*)value.cPtr(false) : null);
  }

  /**
   * Sets the value of the uniform idx.
   * The uniform must be of vec4 type.
   * Params:
   *   idx = index of the uniform
   *   value = value to set the uniform too
   */
  void setVec4(int idx, Vec4 value)
  {
    gsk_shader_args_builder_set_vec4(cast(GskShaderArgsBuilder*)cPtr, idx, value ? cast(graphene_vec4_t*)value.cPtr(false) : null);
  }
}
