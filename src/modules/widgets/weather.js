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
  const forecasts = [null, null, null, null, null];
  // const forecasts = [
  //   null,
  //   ['mist', 12],
  //   ['cloud+', -34],
  //   ['rain', 4],
  //   ['snow', -12],
  // ];

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

          const date = new Date();
          date.setUTCHours(12);
          date.setMinutes(0);
          date.setSeconds(0);
          date.setMilliseconds(0);

          // loop on forecast items to get weather at midday
          for (let j = 0; j < COUNT; j++) {
            for (let i = 0; i < resp.list.length; i++) {
              const item = resp.list[i];

              if (item.dt === date.getTime() / 1000) {
                console.log('matched on item', item);
                const temp = Math.round(item.main.temp - 273.15);
                const icon = item.weather[0].icon.substring(0, 2);
                forecasts[j] = ['missing', temp];
                switch (icon) {
                  case '01':
                    forecasts[j][0] = 'clear';
                    break;
                  case '02':
                    forecasts[j][0] = 'cloud';
                    break;
                  case '03':
                    forecasts[j][0] = 'cloud+';
                    break;
                  case '04':
                    forecasts[j][0] = 'cloud++';
                    break;
                  case '09':
                    forecasts[j][0] = 'rain';
                    break;
                  case '10':
                    forecasts[j][0] = 'rain+';
                    break;
                  case '11':
                    forecasts[j][0] = 'rain++';
                    break;
                  case '13':
                    forecasts[j][0] = 'snow';
                    break;
                  case '50':
                    forecasts[j][0] = 'mist';
                    break;
                }
                break;
              }
            }
            date.setDate(date.getDate() + 1);
          }
        });
    },
  };
}
