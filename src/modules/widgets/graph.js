/**
 * @param {number} minX
 * @param {number} maxX
 * @param {number} minY
 * @param {number} maxY
 * @param {number} colorStroke
 * @param {number} colorFill
 * @return {Widget}
 */
export function graphWidget(minX, maxX, minY, maxY, colorStroke, colorFill) {
  const alpha = Math.random();
  const beta = Math.random();
  const height = maxY - minY;

  return {
    render(x, y, prevColor) {
      if (x < minX || x > maxX || y < minY || y > maxY) {
        return prevColor;
      }
      const value = height * 0.5 * (1 + Math.sin(x * alpha));
      if (maxY - y > value) {
        return prevColor;
      }
      return maxY - y < value - 1 ? colorFill : colorStroke;
    },
    update() {},
  };
}
