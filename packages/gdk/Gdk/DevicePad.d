module Gdk.DevicePad;

import Gdk.Types;
import Gdk.c.functions;
import Gdk.c.types;
import Gid.gid;

/**
 * `GdkDevicePad` is an interface implemented by devices of type
 * %GDK_SOURCE_TABLET_PAD
 * It allows querying the features provided by the pad device.
 * Tablet pads may contain one or more groups, each containing a subset
 * of the buttons/rings/strips available. [Gdk.DevicePad.getNGroups]
 * can be used to obtain the number of groups, [Gdk.DevicePad.getNFeatures]
 * and [Gdk.DevicePad.getFeatureGroup] can be combined to find out
 * the number of buttons/rings/strips the device has, and how are they grouped.
 * Each of those groups have different modes, which may be used to map each
 * individual pad feature to multiple actions. Only one mode is effective
 * $(LPAREN)current$(RPAREN) for each given group, different groups may have different
 * current modes. The number of available modes in a group can be found
 * out through [Gdk.DevicePad.getGroupNModes], and the current mode
 * for a given group will be notified through events of type `GDK_PAD_GROUP_MODE`.
 */
interface DevicePad
{

  static GType getType()
  {
    return gdk_device_pad_get_type();
  }

  /**
   * Returns the group the given feature and idx belong to.
   * f the feature or index do not exist in pad, -1 is returned.
   * Params:
   *   feature = the feature type to get the group from
   *   featureIdx = the index of the feature to get the group from
   * Returns: The group number of the queried pad feature.
   */
  int getFeatureGroup(DevicePadFeature feature, int featureIdx);

  /**
   * Returns the number of modes that group may have.
   * Params:
   *   groupIdx = group to get the number of available modes from
   * Returns: The number of modes available in group.
   */
  int getGroupNModes(int groupIdx);

  /**
   * Returns the number of features a tablet pad has.
   * Params:
   *   feature = a pad feature
   * Returns: The amount of elements of type feature that this pad has.
   */
  int getNFeatures(DevicePadFeature feature);

  /**
   * Returns the number of groups this pad device has.
   * Pads have at least one group. A pad group is a subcollection of
   * buttons/strip/rings that is affected collectively by a same
   * current mode.
   * Returns: The number of button/ring/strip groups in the pad.
   */
  int getNGroups();
}
