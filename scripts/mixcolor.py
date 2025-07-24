#!/usr/bin/env python3

def blend_hex_colors(color1: str, color2: str, weight1: float, weight2: float) -> str:
    """Mix 2 hex colors with given weights.

    Args:
        color1 (str): The first hex color, for example "#9dd274"
        color2 (str): The second hex color, for example "#373c4b"
        weight1 (float): The weight of the first hex color.
        weight2 (float): The weight of the second hex color. Note that the sum of weight1 and weight2 should be 1.0

    Returns:
        str: Mixed color code.

    Raises:
        ValueError: When the format of color1/color2 is not correct.
    """
    if (
        not color1.startswith("#")
        or not color2.startswith("#")
        or len(color1) != 7
        or len(color2) != 7
    ):
        raise ValueError("Color format incorrect. Please use strings like '#RRGGBB'.")

    # 1. Parse input color code into rgb integer.
    r1, g1, b1 = int(color1[1:3], 16), int(color1[3:5], 16), int(color1[5:7], 16)
    r2, g2, b2 = int(color2[1:3], 16), int(color2[3:5], 16), int(color2[5:7], 16)

    # 2. Calculate the weighted average for each color channel
    new_r = round(r1 * weight1 + r2 * weight2)
    new_g = round(g1 * weight1 + g2 * weight2)
    new_b = round(b1 * weight1 + b2 * weight2)

    # 3. Convert the calculated new R, G, B values back to hexadecimal and make sure it's a two-digit number.
    # For example 5 should be '05'
    new_r_hex = hex(new_r)[2:].zfill(2)
    new_g_hex = hex(new_g)[2:].zfill(2)
    new_b_hex = hex(new_b)[2:].zfill(2)

    # 4. Format string
    return f"#{new_r_hex}{new_g_hex}{new_b_hex}"

# Example usage:
hex_color_1 = "#9dd274"
weight_1 = 0.3
hex_color_2 = "#373c4b"
weight_2 = 0.7
blended_color = blend_hex_colors(hex_color_1, hex_color_2, weight_1, weight_2)

# Print result:
print(f"{hex_color_1} ({weight_1})")
print(f"{hex_color_2} ({weight_2})")
print(f"Mixed: {blended_color}")
