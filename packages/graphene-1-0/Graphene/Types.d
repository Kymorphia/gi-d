module Graphene.Types;

import Gid.gid;
import Graphene.c.functions;
import Graphene.c.types;


// Enums
alias EulerOrder = graphene_euler_order_t;
alias RayIntersectionKind = graphene_ray_intersection_kind_t;

// Structs
alias Simd4F = graphene_simd4f_t;

enum PI = 3.141593;


enum PI_2 = 1.570796;


/**
 * Evaluates to the number of components of a #graphene_vec2_t.
 * This symbol is useful when declaring a C array of floating
 * point values to be used with [Graphene.Vec2.initFromFloat] and
 * [Graphene.Vec2.toFloat], e.g.
 * |[
 * float v[GRAPHENE_VEC2_LEN];
 * // vec is defined elsewhere
 * graphene_vec2_to_float $(LPAREN)&vec, v$(RPAREN);
 * for $(LPAREN)int i \= 0; i < GRAPHENE_VEC2_LEN; i++$(RPAREN)
 * fprintf $(LPAREN)stdout, "component %d: %g\n", i, v[i]$(RPAREN);
 * ]|
 */
enum VEC2_LEN = 2;


/**
 * Evaluates to the number of components of a #graphene_vec3_t.
 * This symbol is useful when declaring a C array of floating
 * point values to be used with [Graphene.Vec3.initFromFloat] and
 * [Graphene.Vec3.toFloat], e.g.
 * |[
 * float v[GRAPHENE_VEC3_LEN];
 * // vec is defined elsewhere
 * graphene_vec3_to_float $(LPAREN)&vec, v$(RPAREN);
 * for $(LPAREN)int i \= 0; i < GRAPHENE_VEC2_LEN; i++$(RPAREN)
 * fprintf $(LPAREN)stdout, "component %d: %g\n", i, v[i]$(RPAREN);
 * ]|
 */
enum VEC3_LEN = 3;


/**
 * Evaluates to the number of components of a #graphene_vec4_t.
 * This symbol is useful when declaring a C array of floating
 * point values to be used with [Graphene.Vec4.initFromFloat] and
 * [Graphene.Vec4.toFloat], e.g.
 * |[
 * float v[GRAPHENE_VEC4_LEN];
 * // vec is defined elsewhere
 * graphene_vec4_to_float $(LPAREN)&vec, v$(RPAREN);
 * for $(LPAREN)int i \= 0; i < GRAPHENE_VEC4_LEN; i++$(RPAREN)
 * fprintf $(LPAREN)stdout, "component %d: %g\n", i, v[i]$(RPAREN);
 * ]|
 */
enum VEC4_LEN = 4;

