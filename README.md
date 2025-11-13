# Industrial Edge PLC Log Analyzer

<p align="center">
  <img alt="Docker" src="https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white" />
  <img alt="OpenSearch" src="https://img.shields.io/badge/OpenSearch-2.19.4-005EB8" />
  <img alt="Dashboards" src="https://img.shields.io/badge/OpenSearch%20Dashboards-2.19.4-1A73E8" />
</p>

A local-first foundation for analyzing PLC and conveyor-system logs. It provides the OpenSearch backend and Dashboards environment needed to turn large volumes of warehouse event data into searchable diagnostics for the Element Logic troubleshooting use case.

## Use case

Element Logic Germany GmbH needed to find why items were being misdirected in warehouse conveyor systems. Technicians had to search millions of log lines manually; the Siemens report describes a quoted example that took seven days. The target workflow is to load structured production logs, identify recurring error patterns across devices, and give technicians a diagnostic result in minutes rather than days.

This repository currently supplies the local analytics foundation only. The PLC-log parser, ingestion flow, OPC UA/MQTT/REST connectors, and diagnostic rules are not included yet. The reported Siemens hackathon result of approximately 10 minutes to load data and see a result is project context, not a benchmark produced by this repository.

## Project goals

- Provide a reproducible OpenSearch environment for PLC and conveyor event data
- Support dashboards for error investigation, device comparison, and recurring-pattern analysis
- Leave room for an edge-side ingestion workflow using Siemens Industrial Edge, Node-RED, and industrial interfaces such as OPC UA, MQTT, or REST
- Keep local development simple enough for rapid prototyping and demonstrations

## Stack

- OpenSearch 2.19.4
- OpenSearch Dashboards 2.19.4
- Docker Compose v2
- Shared external Docker network named `element-logic`

## Current architecture

```text
PLC / conveyor log sources
  |
  | (ingestion and normalization to be added)
  v
Industrial Edge application (planned)
  |
  v
Developer machine / local demo
    |
    +-- element-logic Docker network
          |
          +-- OpenSearch :9200
          +-- OpenSearch Dashboards :5601
```

Only the OpenSearch and OpenSearch Dashboards services are implemented today. The upstream containers are pulled directly from Docker Hub, keeping the prototype lightweight and easy to review.

## Quick start

Requirements: Docker Desktop or any Docker environment with Compose v2 enabled.

```bash
cp deploy/compose/.env.example deploy/compose/.env
./scripts/start.sh
```

Then open:

- OpenSearch Dashboards: <http://localhost:5601>
- OpenSearch API: <http://localhost:9200>

## Stop the stack

```bash
./scripts/stop.sh
```

## Project layout

```text
deploy/compose/   Docker Compose services and environment templates
docs/             Architecture and operational notes
scripts/          Start/stop helpers for the local stack
```

## Hackathon context

Siemens' first Kicks for Edge Hackathon brought interdisciplinary teams together for three industrial challenges in 72 hours at UTUM Makerspace in Munich. The event focused on practical solutions built with Siemens Industrial Edge. The Element Logic challenge concerned warehouse conveyor troubleshooting; the other challenges came from LEW Wasserkraft and HOLZ automation. Team FER won with an automated nail-quality inspection solution reported at 97% accuracy using one sensor and AI.

The Siemens article was published on 6 February 2026 and does not specify the event’s exact dates. Its reported result for the Element Logic workflow is a reduction from a quoted seven days of manual log analysis to approximately 10 minutes to load data and see the diagnostic result. It does not establish total physical repair time, global deployment, or quantified preventive-maintenance savings.

Source: [Siemens Blog, "Innovation in 72 hours: Kicks for Edge Hackathon"](https://blog.siemens.com/2026/02/innovation-in-72-hours-kicks-for-edge-hackathon/)

## Configuration

The `.env.example` file defines the password and can be copied into a local `.env` before starting the stack.

```bash
cp deploy/compose/.env.example deploy/compose/.env
```

Update the value in the copied file to something strong before using the environment outside a local-only demo setup.

## Security note

This project intentionally disables the OpenSearch security plugins for local development convenience. Do not expose the stack directly to a public network or shared environment without adding proper authentication and hardening.

## License

The repository configuration is provided for local industrial log-analysis workflows. OpenSearch and OpenSearch Dashboards remain subject to their respective upstream licenses.
