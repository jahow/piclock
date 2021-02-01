import './modules/display';
import { addWidget } from './modules/display';
import { testWidget } from './modules/widgets/test';
import { clockWidget } from './modules/widgets/clock';
import { textWidget } from './modules/widgets/text';
import { graphWidget } from './modules/widgets/graph';
import { weatherWidget } from './modules/widgets/weather';

addWidget(clockWidget(7, 2, 1));

// addWidget(testWidget(52, 45, 20, 2));

addWidget(textWidget(11, 19, 'lun. 04-02', 3));

// phase A: temp graph
// addWidget(graphWidget(2, 23, 26, 37, 2, 3));
// addWidget(textWidget(26, 26, 't°', 3));
// addWidget(textWidget(26, 33, '18.2', 2));
//
// addWidget(textWidget(50, 26, 'co2', 3));
// addWidget(textWidget(45, 33, '2420', 2));

// phase b: weather forecast
addWidget(weatherWidget(3, 25, 2));
