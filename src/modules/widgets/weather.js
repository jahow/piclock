import {
  getSymbolChainValue,
  getSymbolChainWidth,
  getSymbolValue,
} from './utils/symbols';
import {
  clockSymbols,
  textSymbols,
  weatherSymbols,
} from './utils/symbols.definitions';

const INTERVAL = 60 * 1000 * 15; // 15 minutes
const COUNT = 5;
const LOCATION = 'sonnaz';
const KEY = 'a48634ed18dac4fc58477ba9a2e9442c';

/**
 * @param {number} baseX
 * @param {number} baseY
 * @param {number} color
 * @return {Widget}
 */
export function weatherWidget(baseX, baseY, color) {
  const spacing = 6;

  let lastCheckTime = 0;

  /** @type {Array<null|[string, number]>} */
  // const forecasts = [null, null, null, null, null];
  const forecasts = [
    null,
    ['mist', 12],
    ['cloud+', -34],
    ['rain', 4],
    ['rain+', -12],
  ];

  return {
    render(x, y, prevColor) {
      let value = 0;
      let currentX = baseX;

      for (let i = 0; i < COUNT; i++) {
        const forecast = forecasts[i];
        const icon = forecast === null ? 'empty' : forecast[0];
        const temp = forecast === null ? 0 : forecast[1];
        const tempKeys = temp.toString(10).split('');
        const tempWidth = getSymbolChainWidth(textSymbols, tempKeys, 1);

        value += getSymbolValue(weatherSymbols, icon, x - currentX, y - baseY);
        value += getSymbolChainValue(
          textSymbols,
          tempKeys,
          1,
          x - 4 - currentX + Math.round(tempWidth / 2),
          y - baseY - 8
        );
        currentX += weatherSymbols.baseWidth + spacing;
      }

      return value > 0 ? color : prevColor;
    },
    update() {
      if (Date.now() < lastCheckTime + INTERVAL) return;

      lastCheckTime = Date.now();

      fetch(
        'https://api.openweathermap.org/data/2.5/forecast?q=' +
          LOCATION +
          '&appid=' +
          KEY
      )
        .then((resp) => resp.json())
        .then((resp) => {
          console.log(resp);
        });
    },
  };
}
