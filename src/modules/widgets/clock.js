import { getSymbolChainValue } from './utils/symbols';
import { clockSymbols } from './utils/symbols.definitions';

/**
 * @param {number} baseX
 * @param {number} baseY
 * @param {number} color
 * @return {Widget}
 */
export function clockWidget(baseX, baseY, color) {
  const chars = ['0', '0', '0', '0', '0', '0'];

  return {
    render(x, y, prevColor) {
      const value = getSymbolChainValue(
        clockSymbols,
        [chars[0], chars[1], ':', chars[2], chars[3]],
        3,
        x - baseX,
        y - baseY
      );
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
