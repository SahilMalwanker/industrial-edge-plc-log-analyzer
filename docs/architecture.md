# Architecture

This repository is the local analytics foundation for the Element Logic warehouse-conveyor troubleshooting use case described in Siemens’ Kicks for Edge Hackathon report. Its current implementation keeps a deliberately small footprint: a shared Docker network, one OpenSearch service, and one Dashboards service.

```text
PLC and conveyor logs
    |
    | Planned: edge ingestion and normalization
    v
Siemens Industrial Edge application
    |
    v
Developer machine / local demo
    |
    +-- element-logic Docker network
          |
          +-- OpenSearch :9200
          +-- OpenSearch Dashboards :5601
```

OpenSearch Dashboards connects to the service name `opensearch` over the shared external network. The setup allows the Compose files to be started and stopped independently while preserving service discovery between the containerized components.

## Implemented scope

The repository owns deployment configuration, environment templates, and local developer workflows. It does not currently include a PLC-log parser, data ingestion pipeline, Node-RED flow, industrial protocol connector, or diagnostic algorithm. It also does not vendor upstream source code or generated plugin assets for OpenSearch Dashboards.

## Intended workflow

1. Collect production events from conveyor and PLC systems at the edge.
2. Normalize raw logs into a consistent event shape across devices and sites.
3. Index events in OpenSearch for error and recurring-pattern analysis.
4. Use OpenSearch Dashboards to investigate device behavior and support troubleshooting.

The future ingestion layer may connect through OPC UA, MQTT, or REST and may support decentralized collection with centralized analysis. Those are design goals from the project brief, not capabilities implemented by the current Compose stack.

## Design intent

- Minimal operational overhead
- Local-first experimentation for industrial log analytics
- Clear separation between platform configuration and future application logic
- Easy reproduction in a standard Docker environment
- A path from edge-side collection to centralized diagnostics
