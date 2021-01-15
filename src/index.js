import './modules/display';
import { addWidget } from './modules/display';
import { testWidget } from './modules/widgets/test';
import { clockWidget } from './modules/widgets/clock';
import { textWidget } from './modules/widgets/text';

addWidget(clockWidget(2, 2, 1));

addWidget(testWidget(52, 45, 20, 2));

addWidget(textWidget(56, 5, 'lun.', 2));
addWidget(textWidget(56, 12, '04-02', 2));
addWidget(textWidget(26, 20, 't°', 3));
addWidget(textWidget(26, 27, '18.2', 1));
addWidget(textWidget(26, 34, 'co2', 3));
addWidget(textWidget(26, 41, '421', 1));
