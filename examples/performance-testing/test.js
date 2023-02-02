import { check } from 'k6';
import exec from 'k6/execution';
import http from 'k6/http';
import { Trend, Gauge } from 'k6/metrics';
import { SharedArray } from 'k6/data';

import { textSummary } from "https://jslib.k6.io/k6-summary/0.0.2/index.js";
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/2.4.0/dist/bundle.js";

const endpoint = `http://${__ENV.HOST}:8181/v1/data/rbac/allow?metrics`;
const endpointMetrics = `http://${__ENV.HOST}:8181/metrics`;

const queries = new SharedArray('queries', function () {
  return JSON.parse(open(`${__ENV.QUERY_FILE}`));
});

const handlerTimer = new Trend('timer_server_handler_ns');
const heapInuseBytes = new Gauge('heap_inuse_bytes');

export default function () {
  const query = queries[Math.floor(Math.random() * queries.length)];
  const input = query.input;

  const r = http.post(endpoint, JSON.stringify({input}), {
    headers: { 'Content-Type': 'application/json' },
  });
  handlerTimer.add(r.json().metrics.timer_server_handler_ns);

  if (Math.random() <= 0.1) {
    const met = http.get(endpointMetrics);
    for (const line of met.body.split(/\n/)) {
      if (line.startsWith("go_memstats_heap_inuse_bytes")) {
        const [key, val] = line.split(" ");
        heapInuseBytes.add(val);
      }
    }
  }

  check(r, {
    'expected result': r.json().result === query.expected
  });
}

export function handleSummary(data) {
  const reportRef = `${__ENV.TOOL}-${__ENV.TEST_SIZE}MB-${exec.test.options.scenarios.default.vus}users-${exec.test.options.scenarios.default.duration}`;
  const reportName = `report-${reportRef}.html`

  return {
    [reportName]: htmlReport(data, {title: reportRef})
  };
}
