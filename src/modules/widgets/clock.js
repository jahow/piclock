/**
 * @param {number} baseX
 * @param {number} baseY
 * @param {number} color
 * @return {Widget}
 */
import { clockSymbols, getSymbolValue, getSymbolWidth } from './utils/symbols';

export function clockWidget(baseX, baseY, color) {
  const chars = ['0', '0', '0', '0', '0', '0'];

  return {
    render(x, y, prevColor) {
      let currentX = baseX;
      const startY = baseY;
      const padding = 3;
      let value = 0;

      value += getSymbolValue(clockSymbols, chars[0], x - currentX, y - startY);
      currentX += getSymbolWidth(clockSymbols, chars[0]) + padding;

      value += getSymbolValue(clockSymbols, chars[1], x - currentX, y - startY);
      currentX += getSymbolWidth(clockSymbols, chars[1]) + padding;

      value += getSymbolValue(clockSymbols, ':', x - currentX, y - startY);
      currentX += getSymbolWidth(clockSymbols, ':') + padding;

      value += getSymbolValue(clockSymbols, chars[2], x - currentX, y - startY);
      currentX += getSymbolWidth(clockSymbols, chars[2]) + padding;

      value += getSymbolValue(clockSymbols, chars[3], x - currentX, y - startY);
      currentX += getSymbolWidth(clockSymbols, chars[3]) + padding;

      value += getSymbolValue(clockSymbols, ':', x - currentX, y - startY);
      currentX += getSymbolWidth(clockSymbols, ':') + padding;

      value += getSymbolValue(clockSymbols, chars[4], x - currentX, y - startY);
      currentX += getSymbolWidth(clockSymbols, chars[4]) + padding;

      value += getSymbolValue(clockSymbols, chars[5], x - currentX, y - startY);
      currentX += getSymbolWidth(clockSymbols, chars[5]) + padding;

      return value > 0 ? color : prevColor;
    },
    update() {
      const hours = new Date().getHours().toString(10).padStart(2, '0');
      const minutes = new Date().getMinutes().toString(10).padStart(2, '0');
      const seconds = new Date().getSeconds().toString(10).padStart(2, '0');
      chars[0] = hours[0];
      chars[1] = hours[1];
      chars[2] = minutes[0];
      chars[3] = minutes[1];
      chars[4] = seconds[0];
      chars[5] = seconds[1];
    },
  };
}
