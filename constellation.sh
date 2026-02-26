# ── MCP Integration ──────────────────────────────────────────────
if [ "$USE_MCP" = "true" ]; then
  echo ""
  echo "── MCP Orchestration Mode ───────────────────────────────────"
  echo "  Using MCP server for agent coordination"
  # Check if MCP server is running
  if curl -s http://localhost:8080/mcp/agent-status > /dev/null 2>&1; then
    echo "  [✓] MCP server is online"
    # Use MCP client for orchestration
    python3 mcp_client.py orchestrate "$PRUNED" "$MCP_STRATEGY" > mcp_result.json
    echo "  [✓] MCP orchestration complete"
    cat mcp_result.json | jq .
  else
    echo "  [✗] MCP server not running - start with: python3 mcp_server.py"
    echo "  [*] Falling back to local orchestration"
  fi
fi
